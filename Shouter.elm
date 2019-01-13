module Shouter exposing (Model, Msg(..), main, shout, update, view)

import Browser
import Html exposing (Attribute, Html, div, input, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)


main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }


type alias Model =
    { message : String }


type Msg
    = Message String


init : Model
init =
    { message = "" }


update : Msg -> Model -> Model
update msg model =
    case msg of
        Message s ->
            Model s


view : Model -> Html Msg
view model =
    div []
        [ input
            [ placeholder "Speak"
            , onInput Message
            ]
            []
        , div
            [ style "color" "red"
            , style "font-size" "40px"
            ]
            [ text (shout model.message) ]
        ]


shout : String -> String
shout m =
    if String.isEmpty m then
        ""

    else
        String.toUpper m ++ "!!"
