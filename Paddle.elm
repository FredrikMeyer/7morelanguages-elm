module Paddle exposing (Model, Msg(..), init, main, subscriptions, update, view)

import Browser
import Browser.Dom exposing (Viewport, getViewport)
import Browser.Events
import Collage exposing (..)
import Collage.Layout as Layout exposing (stack)
import Collage.Render as Render exposing (svg)
import Color exposing (..)
import Html exposing (Html)
import Html.Attributes
import Json.Decode as Decode
import Task


type alias MousePosition =
    { x : Float
    , y : Float
    }


type alias Size =
    { width : Float
    , height : Float
    }


type Msg
    = GetViewport Viewport
    | MouseMoved MousePosition


type alias Model =
    { size : Maybe Size
    , xPosition : Float
    }


main : Program Decode.Value Model Msg
main =
    Browser.document
        { init = always init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


init : ( Model, Cmd Msg )
init =
    ( { size = Nothing
      , xPosition = 0
      }
    , Cmd.batch
        [ Task.perform GetViewport getViewport ]
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GetViewport { viewport } ->
            ( { model
                | size =
                    Just <|
                        Size viewport.width viewport.height
              }
            , Cmd.none
            )

        MouseMoved position ->
            ( { model | xPosition = position.x }, Cmd.none )


view : Model -> Browser.Document msg
view model =
    { title = "HEI"
    , body =
        case model.size of
            Just size ->
                [ display ( size.width, size.height ) model.xPosition
                ]

            Nothing ->
                [ Html.text "Loading..." ]
    }


decodePosition : Decode.Decoder MousePosition
decodePosition =
    Decode.map2 MousePosition
        (Decode.field "clientX" Decode.float)
        (Decode.field "clientY" Decode.float)


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.map MouseMoved <| Browser.Events.onMouseMove decodePosition


display : ( Float, Float ) -> Float -> Html msg
display ( w, h ) x =
    Layout.stack
        [ drawPaddle w h x
        , rectangle (w - 50) (h - 50) |> filled (uniform white)
        ]
        |> Render.svg


drawPaddle : Float -> Float -> Float -> Collage msg
drawPaddle w h x =
    rectangle 80 10
        |> filled (uniform black)
        |> shiftX (x - w / 2)
        |> shiftY (h * -0.45)
