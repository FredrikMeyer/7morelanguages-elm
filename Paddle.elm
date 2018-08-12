module Paddle exposing (..)

import Html exposing (..)
import Color exposing (..)
import Collage exposing (..)
import Element exposing (..)
import Mouse exposing (Position)
import Window exposing (Size)
import Task exposing (..)
import Maybe exposing (..)


type alias Model =
    { size : Maybe Size
    , xPos : Int
    }


type Msg
    = MousePos Mouse.Position
    | SetWindowSize Window.Size


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


init : ( Model, Cmd Msg )
init =
    let
        windowSize =
            Task.perform SetWindowSize Window.size
    in
        ( { size = Nothing
          , xPos = 0
          }
        , windowSize
        )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MousePos pos ->
            ( { model | xPos = pos.x }, Cmd.none )

        SetWindowSize size ->
            ( { model | size = Just size }, Cmd.none )


view : Model -> Html Msg
view model =
    case model.size of
        Just size ->
            let
                width =
                    size.width

                height =
                    size.height

                xPos =
                    model.xPos
            in
                toHtml <| display ( width, height ) xPos

        Nothing ->
            Html.text "Loading..."


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Mouse.moves (\p -> MousePos p)
        , Window.resizes (\s -> SetWindowSize s)
        ]


drawPaddle : Int -> Int -> Int -> Form
drawPaddle w h x =
    filled black (rect 80 10)
        |> moveX (toFloat x - toFloat w / 2)
        |> moveY (toFloat h * -0.45)


display : ( Int, Int ) -> Int -> Element
display ( w, h ) x =
    collage w
        h
        [ drawPaddle w h x ]
