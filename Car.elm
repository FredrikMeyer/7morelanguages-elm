module Car exposing (..)

import Html exposing (..)
import Color exposing (..)
import Collage exposing (..)
import Element exposing (..)


carBottom =
    filled black (rect 160 50)


carTop =
    filled darkBlue (rect 100 60)


tire =
    filled red (circle 24)


main =
    toHtml
        (collage 300
            300
            [ carTop |> moveY 30
            , carBottom
            , tire |> move ( -40, -28 )
            , tire |> move ( 40, -28 )
            ]
        )
