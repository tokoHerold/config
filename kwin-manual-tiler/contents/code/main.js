// -- Enums --

const Direction = Object.freeze({
    UP: 0,
    DOWN: 1,
    LEFT: 2,
    RIGHT: 3
});

// Encapsulates a the window position
const WindowState = Object.freeze({
    UNKNOWN: 0,
    LEFT_HALF: 1,
    RIGHT_HALF: 2,
    TOP_HALF: 3,
    BOTTOM_HALF: 4,
    TOP_LEFT: 5,
    TOP_RIGHT: 6,
    BOTTOM_LEFT: 7,
    BOTTOM_RIGHT: 8,
    MAXIMIZED: 9
});


// --- Helper Functions ---

// Get the usable screen area (excluding panels), 0 = KWin.MaximizeArea enum
function getArea(win) {
    return workspace.clientArea(0, win);
}

// Get the usable screen area for a specific output (monitor)
function getAreaForScreen(screen) {
    return workspace.clientArea(0, screen, workspace.currentDesktop);
}

// Check if two values are approximately equal (handles 1-2px rounding differences)
function isApprox(val1, val2) {
    return Math.abs(val1 - val2) <= 5;
}

// Finds an adjacent monitor in the given direction
// Args:
// | currentOutput: KWin Output from which to begin looking
// | direction: 	Direction in which to look for
// Returns:
// | Next KWin Output in the desired direction or null.
function getNeighborScreen(currentScreen, direction) {
    const currentRect = currentScreen.geometry;
    const screens = workspace.screens;
    let bestScreen = null;
    let minDistance = Infinity;

    for (let i = 0; i < screens.length; i++) {
        const screen = screens[i];
        if (screen === currentScreen) continue;

        const otherRect = screen.geometry;
        let isValid = false;
        let distance = 0;

        switch (direction) { // Check if screen is in desired direction
            case Direction.LEFT:
                if (otherRect.x + otherRect.width <= currentRect.x &&
                    otherRect.y < currentRect.y + currentRect.height && otherRect.y + otherRect.height > currentRect.y) {
                    isValid = true;
                    distance = currentRect.x - (otherRect.x + otherRect.width);
                }
                break;
            case Direction.RIGHT:
                if (otherRect.x >= currentRect.x + currentRect.width &&
                    otherRect.y < currentRect.y + currentRect.height && otherRect.y + otherRect.height > currentRect.y) {
                    isValid = true;
                    distance = otherRect.x - (currentRect.x + currentRect.width);
                }
                break;
            case Direction.UP:
                if (otherRect.y + otherRect.height <= currentRect.y &&
                    otherRect.x < currentRect.x + currentRect.width && otherRect.x + otherRect.width > currentRect.x) {
                    isValid = true;
                    distance = currentRect.y - (otherRect.y + otherRect.height);
                }
                break;
            case Direction.DOWN:
                if (otherRect.y >= currentRect.y + currentRect.height &&
                    otherRect.x < currentRect.x + currentRect.width && otherRect.x + otherRect.width > currentRect.x) {
                    isValid = true;
                    distance = otherRect.y - (currentRect.y + currentRect.height);
                }
                break;
        }

        if (isValid && distance < minDistance) { // Update if result is valid & better
            minDistance = distance;
            bestScreen = screen;
        }
    }
    return bestScreen;
}

// Determines the current state/position of the window
// Args: 
// | win:	Window object to calculate state for
// | area:	Useable area (see `getArea`)
// Returns:
// | A `WindowState` object describing where the window currently sits
function getWindowState(win, area) {
    const gx = win.frameGeometry.x;
    const gy = win.frameGeometry.y;
    const gw = win.frameGeometry.width;
    const gh = win.frameGeometry.height;

    const halfW = Math.round(area.width / 2);
    const halfH = Math.round(area.height / 2);

    const isFullW = isApprox(gw, area.width);
    const isFullH = isApprox(gh, area.height);

    // If it matches the full screen usable area, we treat it as maximized
    if (isFullW && isFullH) return WindowState.MAXIMIZED;

    const isLeft = isApprox(gx, area.x) && isApprox(gw, halfW);
    const isRight = isApprox(gx, area.x + halfW) && isApprox(gw, area.width - halfW);
    const isTop = isApprox(gy, area.y) && isApprox(gh, halfH);
    const isBottom = isApprox(gy, area.y + halfH) && isApprox(gh, area.height - halfH);

    if (isLeft && isFullH) return WindowState.LEFT_HALF;
    if (isRight && isFullH) return WindowState.RIGHT_HALF;
    if (isTop && isFullW) return WindowState.TOP_HALF;
    if (isBottom && isFullW) return WindowState.BOTTOM_HALF;

    if (isTop && isLeft) return WindowState.TOP_LEFT;
    if (isTop && isRight) return WindowState.TOP_RIGHT;
    if (isBottom && isLeft) return WindowState.BOTTOM_LEFT;
    if (isBottom && isRight) return WindowState.BOTTOM_RIGHT;

    return WindowState.UNKNOWN;
}

// Applies a specific geometry state to the window
// Args: 
// | win:	Window object apply state
// | area:	Size of target screen (see `getArea`)
// | state:	Current `WindowState`
function applyState(win, area, state) {
    if (state === WindowState.MAXIMIZED) {
        win.setMaximize(true, true); // KWin Maximization (identical to the window decorator button)
        return;
    } else {
        win.setMaximize(false, false); // Ensure the window is un-maximized
    }

    let gx = area.x, gy = area.y;
    let gw = area.width, gh = area.height;

    const halfW = Math.round(area.width / 2);
    const halfH = Math.round(area.height / 2);

    switch (state) {
        case WindowState.LEFT_HALF:
            gw = halfW;
            break;
        case WindowState.RIGHT_HALF:
            gx = area.x + halfW;
            gw = area.width - halfW;
            break;
        case WindowState.TOP_HALF:
            gh = halfH;
            break;
        case WindowState.BOTTOM_HALF:
            gy = area.y + halfH;
            gh = area.height - halfH;
            break;
        case WindowState.TOP_LEFT:
            gw = halfW; gh = halfH;
            break;
        case WindowState.TOP_RIGHT:
            gx = area.x + halfW; gw = area.width - halfW; gh = halfH;
            break;
        case WindowState.BOTTOM_LEFT:
            gy = area.y + halfH; gw = halfW; gh = area.height - halfH;
            break;
        case WindowState.BOTTOM_RIGHT:
            gx = area.x + halfW; gy = area.y + halfH; gw = area.width - halfW; gh = area.height - halfH;
            break;
    }
    win.frameGeometry = { x: gx, y: gy, width: gw, height: gh };
}


// --- Main Logic Functions ---

// Tiles the active window on a given input.
// Args:
// | direction: Tile direction, corresponding to all four Custom Tile directions.
function tileDirection(direction) {
    const win = workspace.activeWindow;
    if (!win || win.specialWindow) return;

    const currArea = getArea(win);
    const currState = getWindowState(win, currArea);

    let nextState = null;
    let targetScreen = win.output; // Default to current monitor

    switch (direction) {
        case Direction.LEFT:
            if (currState === WindowState.RIGHT_HALF) nextState = WindowState.LEFT_HALF;
            else if (currState === WindowState.MAXIMIZED) nextState = WindowState.LEFT_HALF;
            else if (currState === WindowState.TOP_RIGHT) nextState = WindowState.TOP_LEFT;
            else if (currState === WindowState.BOTTOM_RIGHT) nextState = WindowState.BOTTOM_LEFT;
            else if (currState === WindowState.TOP_HALF) nextState = WindowState.TOP_LEFT;
            else if (currState === WindowState.BOTTOM_HALF) nextState = WindowState.BOTTOM_LEFT;
            else if (currState === WindowState.UNKNOWN) nextState = WindowState.LEFT_HALF;
            else if (currState === WindowState.LEFT_HALF || currState === WindowState.TOP_LEFT || currState === WindowState.BOTTOM_LEFT) {
                let neighbor = getNeighborScreen(win.output, Direction.LEFT);
                if (neighbor) {
                    targetScreen = neighbor;
                    if (currState === WindowState.LEFT_HALF) nextState = WindowState.RIGHT_HALF;
                    else if (currState === WindowState.TOP_LEFT) nextState = WindowState.TOP_RIGHT;
                    else if (currState === WindowState.BOTTOM_LEFT) nextState = WindowState.BOTTOM_RIGHT;
                }
            }
            break;

        case Direction.RIGHT:
            if (currState === WindowState.LEFT_HALF) nextState = WindowState.RIGHT_HALF;
            else if (currState === WindowState.MAXIMIZED) nextState = WindowState.RIGHT_HALF;
            else if (currState === WindowState.TOP_LEFT) nextState = WindowState.TOP_RIGHT;
            else if (currState === WindowState.BOTTOM_LEFT) nextState = WindowState.BOTTOM_RIGHT;
            else if (currState === WindowState.TOP_HALF) nextState = WindowState.TOP_RIGHT;
            else if (currState === WindowState.BOTTOM_HALF) nextState = WindowState.BOTTOM_RIGHT;
            else if (currState === WindowState.UNKNOWN) nextState = WindowState.RIGHT_HALF;
            else if (currState === WindowState.RIGHT_HALF || currState === WindowState.TOP_RIGHT || currState === WindowState.BOTTOM_RIGHT) {
                let neighbor = getNeighborScreen(win.output, Direction.RIGHT);
                if (neighbor) {
                    targetScreen = neighbor;
                    if (currState === WindowState.RIGHT_HALF) nextState = WindowState.LEFT_HALF;
                    else if (currState === WindowState.TOP_RIGHT) nextState = WindowState.TOP_LEFT;
                    else if (currState === WindowState.BOTTOM_RIGHT) nextState = WindowState.BOTTOM_LEFT;
                }
            }
            break;

        case Direction.UP:
            if (currState === WindowState.MAXIMIZED) {
                let neighbor = getNeighborScreen(win.output, Direction.UP);
                if (neighbor) {
                    targetScreen = neighbor;
                    nextState = WindowState.MAXIMIZED;
                }
            }
            else if (currState === WindowState.BOTTOM_HALF) nextState = WindowState.TOP_HALF;
            else if (currState === WindowState.BOTTOM_LEFT) nextState = WindowState.TOP_LEFT;
            else if (currState === WindowState.BOTTOM_RIGHT) nextState = WindowState.TOP_RIGHT;
            else if (currState === WindowState.LEFT_HALF) nextState = WindowState.TOP_LEFT;
            else if (currState === WindowState.RIGHT_HALF) nextState = WindowState.TOP_RIGHT;
            else if (currState === WindowState.UNKNOWN) nextState = WindowState.TOP_HALF;
            else if (currState === WindowState.TOP_HALF || currState === WindowState.TOP_LEFT || currState === WindowState.TOP_RIGHT) {
                let neighbor = getNeighborScreen(win.output, Direction.UP);
                if (neighbor) {
                    targetScreen = neighbor;
                    if (currState === WindowState.TOP_HALF) nextState = WindowState.BOTTOM_HALF;
                    else if (currState === WindowState.TOP_LEFT) nextState = WindowState.BOTTOM_LEFT;
                    else if (currState === WindowState.TOP_RIGHT) nextState = WindowState.BOTTOM_RIGHT;
                } else {
                    nextState = WindowState.MAXIMIZED;
                }
            }
            break;

        case Direction.DOWN:
            if (currState === WindowState.MAXIMIZED) nextState = WindowState.BOTTOM_HALF;
            else if (currState === WindowState.TOP_HALF) nextState = WindowState.BOTTOM_HALF;
            else if (currState === WindowState.TOP_LEFT) nextState = WindowState.BOTTOM_LEFT;
            else if (currState === WindowState.TOP_RIGHT) nextState = WindowState.BOTTOM_RIGHT;
            else if (currState === WindowState.LEFT_HALF) nextState = WindowState.BOTTOM_LEFT;
            else if (currState === WindowState.RIGHT_HALF) nextState = WindowState.BOTTOM_RIGHT;
            else if (currState === WindowState.UNKNOWN) nextState = WindowState.BOTTOM_HALF;
            else if (currState === WindowState.BOTTOM_HALF || currState === WindowState.BOTTOM_LEFT || currState === WindowState.BOTTOM_RIGHT) {
                let neighbor = getNeighborScreen(win.output, Direction.DOWN);
                if (neighbor) {
                    targetScreen = neighbor;
                    if (currState === WindowState.BOTTOM_HALF) nextState = WindowState.TOP_HALF;
                    else if (currState === WindowState.BOTTOM_LEFT) nextState = WindowState.TOP_LEFT;
                    else if (currState === WindowState.BOTTOM_RIGHT) nextState = WindowState.TOP_RIGHT;
                }
            }
            break;
    }

    if (nextState !== null) {
        if (targetScreen !== win.output) { // Move the window to the target monitor if it jumped
            workspace.sendClientToScreen(win, targetScreen);
        }
        const targetArea = getAreaForScreen(targetScreen);
        applyState(win, targetArea, nextState);
    }
}

// Expands the currently active window, based on its current position and input.
// Args:
// | direction: Tile direction, corresponding to all four Custom Tile directions.
function expandWindow(direction) {
    const win = workspace.activeWindow;
    if (!win || win.specialWindow) return;

    const area = getArea(win);

    let gx = win.frameGeometry.x;
    let gy = win.frameGeometry.y;
    let gw = win.frameGeometry.width;
    let gh = win.frameGeometry.height;

    // Maximize window if on top screen edge
    if (direction === Direction.UP && isApprox(gy, area.y)) {
        win.setMaximize(true, true);
        return;
    }

    win.setMaximize(false, false);

    switch (direction) {
        case Direction.LEFT:
            let leftDiff = gx - area.x;
            gx = area.x;
            gw = gw + leftDiff;
            break;
        case Direction.RIGHT:
            let rightEdge = gx + gw;
            let areaRight = area.x + area.width;
            gw = gw + (areaRight - rightEdge);
            break;
        case Direction.UP:
            let topDiff = gy - area.y;
            gy = area.y;
            gh = gh + topDiff;
            break;
        case Direction.DOWN:
            let bottomEdge = gy + gh;
            let areaBottom = area.y + area.height;
            gh = gh + (areaBottom - bottomEdge);
            break;
    }

    win.frameGeometry = { x: gx, y: gy, width: gw, height: gh };
}


// --- Register Shortcuts ---
registerShortcut("Custom Tile Left", "Tile/Move Left", "Meta+Left", function() { tileDirection(Direction.LEFT); });
registerShortcut("Custom Tile Right", "Tile/Move Right", "Meta+Right", function() { tileDirection(Direction.RIGHT); });
registerShortcut("Custom Tile Top", "Tile/Move Up", "Meta+Up", function() { tileDirection(Direction.UP); });
registerShortcut("Custom Tile Bottom", "Tile/Move Down", "Meta+Down", function() { tileDirection(Direction.DOWN); });

registerShortcut("Custom Expand Left", "Expand window left", "Meta+Shift+Left", function() { expandWindow(Direction.LEFT); });
registerShortcut("Custom Expand Right", "Expand window right", "Meta+Shift+Right", function() { expandWindow(Direction.RIGHT); });
registerShortcut("Custom Expand Top", "Expand window top", "Meta+Shift+Up", function() { expandWindow(Direction.UP); });
registerShortcut("Custom Expand Bottom", "Expand window bottom", "Meta+Shift+Down", function() { expandWindow(Direction.DOWN); });
