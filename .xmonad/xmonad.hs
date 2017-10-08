-- Various
import XMonad
import System.IO
import System.Exit
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import Control.Monad

-- Hooks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.EwmhDesktops

-- Utils
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.Paste
import XMonad.Util.Scratchpad
import XMonad.Util.Dmenu

-- layouts
import XMonad.Layout.Decoration
import XMonad.Layout.NoBorders
import XMonad.Layout.Fullscreen
import XMonad.Layout.ResizableTile
import XMonad.Layout.Reflect
import XMonad.Layout.IM
import XMonad.Layout.Tabbed
import XMonad.Layout.PerWorkspace (onWorkspace)
import XMonad.Layout.Grid
import XMonad.Layout.ComboP
import XMonad.Layout.Column
import XMonad.Layout.Named
import XMonad.Layout.TwoPane
import XMonad.Layout.Spiral
import XMonad.Layout.ThreeColumns
import XMonad.Layout.TabBarDecoration
import XMonad.Actions.FloatKeys

------------------------------------------------------------------------------------------------------------------------------------------
-- Main --
main = do
        xmproc <- spawnPipe "xmobar /home/tigerjack/.config/xmobar/.xmobarrc"
        xmonad $ ewmh def {
                  keys = myKeys
                , mouseBindings = myMouseBindings
                , borderWidth = myBorderWidth
                , normalBorderColor = myNormalBorderColor
                , focusedBorderColor = myFocusedBorderColor
                , modMask = myModMask
                , terminal = myTerminal
                , workspaces = myWorkspaces
                , focusFollowsMouse = False
                , manageHook = manageDocks <+> myManageHook <+> manageHook def
                , handleEventHook = mconcat
                        [ docksEventHook
                        , handleEventHook def
			, XMonad.Hooks.EwmhDesktops.fullscreenEventHook ]
                , layoutHook = smartBorders $ myLayoutHook
                , logHook = dynamicLogWithPP $ xmobarPP { 
                          ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "#1A98FF" "" . shorten 70
                        , ppCurrent = xmobarColor "#1A98FF" ""
                        , ppSep = "--"
                        }
                }


---------------------------------------------------------------------
-- COMMANDS


-- The command to lock the screen or show the screensaver.
myCScreensaver = "loginctl lock-session"

-- The command to take a fullscreen screenshot.
myCScreenshotFull = "scrot '/mnt/internal/Data/PersonalFolder/Pictures/NotShotwelled/Screenshots/%Y-%m-%d-%H-%M-%S_$wx$h.png' -e 'xclip -selection clipboard -t image/png -i $f'"
-- The command to take a selective screenshot, where you select
-- what you'd like to capture on the screen.
myCScreenshotSelect = "sleep 0.2; scrot -s '/mnt/internal/Data/PersonalFolder/Pictures/NotShotwelled/Screenshots/%Y-%m-%d-%H-%M-%S_$wx$h_$wx$h.png' -e 'xclip -selection clipboard -t image/png -i $f'"
-- "sleep 0.2; scrot -s -e 'mv $f /mnt/internal/Data/PersonalFolder/Pictures/NotShotwelled/Screenshots/'"

-- The command to take a screenshot of the active window.
myCScreenshotActive = "sleep 0.2; scrot -u '/mnt/internal/Data/PersonalFolder/Pictures/NotShotwelled/Screenshots/%Y-%m-%d-%H-%M-%S_$wx$h_$wx$h.png' -e 'xclip -selection clipboard -t image/png -i $f'"

-- The command to use as a launcher, to launch commands that don't have
-- preset keybindings.
myCLauncher = "$(yeganesh -x -- -fn '-*-terminus-*-r-normal-*-*-120-*-*-*-*-iso8859-*' -nb '#000000' -nf '#FFFFFF' -sb '#7C7C7C' -sf '#CEFFAC')"

-- To show a confirm dialog (f.e. before quitting xmonad)
myCConfirm :: String -> X () -> X ()
myCConfirm msg f = do
  result <- dmenu [msg, "y", "n"]
  when (result == "y") f

-- My settings --
myTerminal ="urxvt"
myWorkspaces =  map show [0..2] ++ ["3:Tasks", "4", "5", "6:study","7:social","8:vm","9:media"]

------------------------------------------------------------------------
-- Window rules
-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook :: ManageHook
myManageHook = composeAll
    [ resource  =? "desktop_window" --> doIgnore
    , className =? "Steam"          --> doFloat
    , className =? "Gimp"           --> doFloat
    , resource  =? "feh"            --> doFloat
    , className =? "MPlayer"        --> doShift "9:media"
    , className =? "smplayer"       --> doShift "9:media"
    , className =? "mpv"            --> doShift "9:media"
    , className =? "spotify"            --> doShift "9:media"
--    , className =? "MPlayer"        --> doFloat
--    , className =? "smplayer"       --> doFloat
    , className =? "mpv"       --> doFloat
    , className =? "VirtualBox"     --> doShift "8:vm"
    , className =? "TelegramDesktop"--> doShift "7:social"
    , className =? "Calibre-gui"    --> doShift "9:media"
    , className =? "Gimp"           --> doShift "9:media"
    , manageDocks
    , scratchpadManageHook (W.RationalRect 0.125 0.25 0.75 0.5)
    , isFullscreen                  --> (doF W.focusDown <+> doFullFloat)]

------------------------------------------------------------------------
-- Layouts
-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myLayoutHook = avoidStruts (
    Tall 1 (3/100) (1/2) |||
    tabbed shrinkText myTabConfig |||
    noBorders (fullscreenFull Full)) |||
    ThreeColMid 1 (3/100) (1/2)
--        spiral (6/7)) |||
--     Mirror (Tall 1 (3/100) (1/2)) |||
--    Full |||
 
------------------------------------------------------------------------
-- Colors and borders
--
myNormalBorderColor  = "#7c7c7c"
myFocusedBorderColor = "#07A900"

-- Colors for text and backgrounds of each tab when in "Tabbed" layout.
myTabConfig = def {
    activeBorderColor = "#7C7C7C",
    activeTextColor = "#176DD5",
    activeColor = "#000000",
    inactiveBorderColor = "#7C7C7C",
    inactiveTextColor = "#EEEEEE",
    inactiveColor = "#000000",
    fontName = "xft:DejaVu Sans Mono:size=13",
    decoHeight = 26
    }

-- Color of current window title in xmobar.
xmobarTitleColor = "#FFB6B0"

-- Color of current workspace in xmobar.
xmobarCurrentWorkspaceColor = "#CEFFAC"

-- Width of the window border in pixels.
myBorderWidth = 3


------------------------------------------------------------------------
-- Key bindings
--
-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask = mod4Mask

myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
  ----------------------------------------------------------------------
  -- Custom key bindings
  --

  -- Start a terminal.  Terminal to start is specified by myTerminal variable.
  [ ((modMask .|. shiftMask, xK_Return),
     spawn $ XMonad.terminal conf)

  -- Lock the screen using command specified by myScreensaver.
  , ((modMask .|. shiftMask, xK_z),
     spawn myCScreensaver)

  -- Spawn the launcher using command specified by myLauncher.
  -- Use this to launch programs without a key binding.
  , ((modMask .|. shiftMask, xK_semicolon),
     spawn myCLauncher)

  -- Take a full screenshot using the command specified by myScreenshot.
  , ((modMask .|. controlMask, xK_Print),
    spawn myCScreenshotFull)

  -- Take a selective screenshot using the command specified by mySelectScreenshot.
  , ((modMask .|. shiftMask, xK_Print),
     spawn myCScreenshotSelect)

  -- Take a screenshot of active window using the command specified by myScreenshot.
  , ((modMask .|. mod1Mask, xK_Print),
    spawn myCScreenshotActive)
--------------------------------------------------------------------
  -- Modified "Standard" xmonad key bindings
  --

  -- Close focused window.
  , ((modMask .|. shiftMask, xK_x),
     kill)

  -- Cycle through the available layout algorithms.
  , ((modMask, xK_space),
     sendMessage NextLayout)

  --  Reset the layouts on the current workspace to default.
  , ((modMask .|. controlMask, xK_space),
     setLayout $ XMonad.layoutHook conf)

  -- Resize viewed windows to the correct size.
  , ((modMask, xK_n),
     refresh)

  -- Move focus to the next window.
  , ((modMask, xK_Tab),
     windows W.focusDown)

  -- Move focus to the next window.
  , ((modMask, xK_j),
     windows W.focusDown)

  -- Move focus to the previous window.
  , ((modMask, xK_k),
     windows W.focusUp  )

  -- Move focus to the master window.
  , ((modMask, xK_m),
     windows W.focusMaster  )

  -- Swap the focused window and the master window.
  , ((modMask, xK_Return),
     windows W.swapMaster)

  -- Swap the focused window with the next window.
  , ((modMask .|. shiftMask , xK_bracketright),
     windows W.swapDown  )

  -- Swap the focused window with the previous window.
  , ((modMask .|. shiftMask, xK_bracketleft),
     windows W.swapUp    )

  -- Shrink the master area.
  , ((modMask .|. shiftMask, xK_h),
     sendMessage Shrink)

  -- Expand the master area.
  , ((modMask .|. shiftMask, xK_l),
     sendMessage Expand)

  -- Push window back into tiling.
  , ((modMask, xK_t),
     withFocused $ windows . W.sink)

  -- Increment the number of windows in the master area.
  , ((modMask, xK_comma),
     sendMessage (IncMasterN 1))

  -- Decrement the number of windows in the master area.
  , ((modMask, xK_period),
     sendMessage (IncMasterN (-1)))

  -- Quit xmonad.
  , ((modMask .|. shiftMask, xK_q),
     myCConfirm "Exit" $ io (exitWith ExitSuccess))

  -- Restart xmonad.
  , ((modMask, xK_q),
     restart "xmonad" True)

--------------------------------------------------------------------
-- Float key actions
--
  , ((modMask,               xK_Right     ), 
     withFocused (keysMoveWindow (5,0) ))
  , ((modMask,               xK_Left     ), 
     withFocused (keysMoveWindow (-5,0) ))
  , ((modMask,               xK_Down     ), 
     withFocused (keysMoveWindow (0,5) ))
  , ((modMask,               xK_Up     ), 
     withFocused (keysMoveWindow (0, -5) ))

  , ((modMask  .|. shiftMask , xK_Right     ), 
     withFocused (keysResizeWindow (10,0) (0, 0) ))
  , ((modMask  .|. shiftMask , xK_Left     ), 
     withFocused (keysResizeWindow (-10,0) (0, 0) ))
  , ((modMask .|. shiftMask , xK_Down     ), 
     withFocused (keysResizeWindow (0,10) (0, 0) ))
  , ((modMask .|. shiftMask , xK_Up     ), 
     withFocused (keysResizeWindow (0,-10) (0, 0) ))
  ]
  ++

  -- mod-[1..9], Switch to workspace N
  -- mod-shift-[1..9], Move client to workspace N
  [((m .|. modMask, k), windows $ f i)
      | (i, k) <- zip (XMonad.workspaces conf) [xK_0 .. xK_9]
      , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
  ++

  -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
  -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
  [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
      | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
      , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


------------------------------------------------------------------------
-- Mouse bindings
--
-- Focus rules
-- True if your focus should follow your mouse cursor.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList $
  [
    -- mod-button1, Set the window to floating mode and move by dragging
    ((modMask, button1),
     (\w -> focus w >> mouseMoveWindow w))

    -- mod-button2, Raise the window to the top of the stack
    , ((modMask, button2),
       (\w -> focus w >> windows W.swapMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modMask, button3),
       (\w -> focus w >> mouseResizeWindow w))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
  ]

