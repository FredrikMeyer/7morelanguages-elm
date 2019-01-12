module Car exposing (main)

import Collage exposing (..)
import Collage.Layout as Layout exposing (stack)
import Collage.Render as Render exposing (svg)
import Color exposing (..)
import Html exposing (Html)


main : Html msg
main =
    let
        windows =
            rectangle 100 60
                |> filled (uniform darkBlue)
                |> shiftY 30

        body =
            rectangle 160 50
                |> filled (uniform black)

        tire =
            circle 24
                |> filled (uniform red)

        leftTire =
            tire
                |> shift ( -40, -28 )

        rightTire =
            tire
                |> shift ( 40, -28 )
    in
    Layout.stack
        [ rightTire
        , leftTire
        , body
        , windows
        ]
        |> Render.svg
