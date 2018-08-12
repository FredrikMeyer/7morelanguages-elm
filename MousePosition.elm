module MousePosition exposing (..)

import Html exposing (..)
import Mouse exposing (Position)


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


init : ( Model, Cmd Msg )
init =
    ( Position 0 0, Cmd.none )


type alias Model =
    Position


type alias Msg =
    Position


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( msg, Cmd.none )


view : Model -> Html Msg
view model =
    div []
        [ text (posToString model) ]


posToString : Position -> String
posToString position =
    "(" ++ toString position.x ++ ", " ++ toString position.y ++ ")"


subscriptions : Model -> Sub Msg
subscriptions model =
    Mouse.moves (\{ x, y } -> Position x y)
