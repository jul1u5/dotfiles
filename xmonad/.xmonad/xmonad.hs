module Main where

import           XMonad
import           XMonad.Layout.LayoutModifier
import           XMonad.Layout.Decoration
import           XMonad.Layout.Tabbed
import           XMonad.Layout.NoBorders
import           XMonad.Layout.Spacing
import           XMonad.Hooks.EwmhDesktops
import           XMonad.Hooks.ManageDocks
import           XMonad.Hooks.ManageHelpers
import           XMonad.Util.EZConfig

import           Graphics.X11.ExtraTypes.XF86

import           SideDecorations
import           EWMHFullscreen

main =
  xmonad
    $                docks
    $                ewmh
    $                def { terminal        = "alacritty"
                         , modMask         = modMask'
                         , startupHook     = startupHook'
                         , layoutHook      = layoutHook'
                         , handleEventHook = fullscreenEventHook <+> handleEventHook def
                         , manageHook      = manageHook' <+> manageHook def
                         }
    `additionalKeys` keys'


modMask' = mod4Mask

decorate' :: Eq a => l a -> ModifiedLayout (Decoration SideDecoration DefaultShrinker) l a
decorate' = decoration shrinkText def (SideDecoration U)

startupHook' = do
  spawn "killall taffybar-linux-; taffybar"
  addEWMHFullscreen

layoutHook' = avoidStruts . smartBorders $ tiled ||| tabbed shrinkText def ||| Full
 where
  tiled   = spacingRaw True (Border 1 1 1 1) True (Border 2 2 2 2) True $ Tall nmaster delta ratio
  -- The default number of windows in the master pane
  nmaster = 1
  -- Default proportion of screen occupied by master pane
  ratio   = 1 / 2
  -- Percent of screen to increment by when resizing panes
  delta   = 3 / 100

manageHook' = composeAll [isFullscreen --> doFullFloat, isDialog --> doCenterFloat]

keys' =
  [ ((0, xF86XK_AudioRaiseVolume)      , spawn "pactl set-sink-volume @DEFAULT_SINK@ +1.5%")
  , ((0, xF86XK_AudioLowerVolume)      , spawn "pactl set-sink-volume @DEFAULT_SINK@ -1.5%")
  , ((0, xF86XK_AudioMute)             , spawn "pactl set-sink-mute   @DEFAULT_SINK@ toggle")
  , ((shiftMask, xK_KP_Down)           , spawn "playerctl play-pause")
  , ((shiftMask, xK_KP_End)            , spawn "playerctl previous")
  , ((shiftMask, xK_KP_Next)           , spawn "playerctl next")
  , ((0, xF86XK_MonBrightnessUp)       , spawn "xbrightness +5000")
  , ((0, xF86XK_MonBrightnessDown)     , spawn "xbrightness -5000")
  , ((modMask' .|. shiftMask, xK_Up)   , spawn "xrandr --output eDP-1 --rotate normal")
  , ((modMask' .|. shiftMask, xK_Left) , spawn "xrandr --output eDP-1 --rotate left")
  , ((modMask' .|. shiftMask, xK_Down) , spawn "xrandr --output eDP-1 --rotate inverted")
  , ((modMask' .|. shiftMask, xK_Right), spawn "xrandr --output eDP-1 --rotate right")
  , ((modMask', xK_p)                  , spawn "rofi -show drun")
  ]
