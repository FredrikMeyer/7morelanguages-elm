module Shouter exposing (..)

import Html exposing (Html, Attribute, div, input, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)


main =
    Html.beginnerProgram
        { model = model
        , view = view
        , update = update
        }


type alias Model =
    { message : String }


model : Model
model =
    Model ""


type Msg
    = Message String


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
        , div [ textStyle ] [ text (shout model.message) ]
        ]


textStyle =
    style [ ( "color", "red" ), ( "font-size", "40px" ) ]


shout : String -> String
shout m =
    if String.isEmpty m then
        ""
    else
        (String.toUpper m) ++ "!!"
