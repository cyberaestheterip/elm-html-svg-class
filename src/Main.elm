module Main exposing (..)

import Browser
import Html exposing (div, ul, li, text)
import Html.Attributes exposing (class)
import Http
import Json.Decode exposing (Value)
import Svg exposing (svg, use)
import Svg.Attributes exposing (xlinkHref)

main = Browser.element
    { init = init
    , subscriptions = subscriptions
    , update = update
    , view = view
    }

init : Value -> ({ data : number }, Cmd Msg)
init flags =
    ({ data = 0 }, getMyFile)

subscriptions model =
    Sub.none

type Msg
    = GotFile (Result Http.Error Int)

update msg model =
    case msg of
        GotFile (Ok ok) ->
            ({ model | data = ok }, Cmd.none)

        GotFile (Err err) ->
            (model, Cmd.none)

view model =
    div []
    [ text (String.fromInt model.data)
    , ul []
        [ li []
            [ svg [ class "asdf" ]
                [ use [xlinkHref "abc"] [] ]
            ]
        ]
    ]

getMyFile =
    Http.get
        { url = "/asset.json"
        , expect = Http.expectJson GotFile fileDecoder
        }

fileDecoder =
    Json.Decode.field "a" Json.Decode.int
