module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (class, style)


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { view = view
        , model = model
        , update = update
        }



--model


type alias Model =
    { xDim : Int
    , yDim : Int
    , paths : List String
    , grid : Html Msg
    , output : String
    }


model : Model
model =
    { xDim = 3
    , yDim = 4
    , paths = []
    , grid = div [] []
    , output = "35"
    }



--update


type Msg
    = IncreaseX
    | DecreaseX
    | IncreaseY
    | DecreaseY
    | FindPaths


update : Msg -> Model -> Model
update msg model =
    case msg of
        IncreaseX ->
            { model
                | xDim = increase model.xDim
                , output = toString (numberOfPaths model.xDim model.yDim)
            }

        DecreaseX ->
            { model
                | xDim = decrease model.xDim
                , output = toString (numberOfPaths model.xDim model.yDim)
            }

        IncreaseY ->
            { model
                | yDim = increase model.yDim
                , output = toString (numberOfPaths model.xDim model.yDim)
            }

        DecreaseY ->
            { model
                | yDim = decrease model.yDim
                , output = toString (numberOfPaths model.xDim model.yDim)
            }

        FindPaths ->
            { model
                | paths = getFinalPath model.xDim model.yDim :: model.paths
                , output = toString (numberOfPaths model.xDim model.yDim)
                , grid = generateGrid model.xDim model.yDim
            }


decrease : Int -> Int
decrease n =
    if n > 1 then
        n - 1
    else
        n


increase : Int -> Int
increase n =
    if n < 10 then
        n + 1
    else
        n


factorial : Int -> Int
factorial n =
    if n == 0 || n == 1 then
        1
    else
        n * factorial (n - 1)


numberOfPaths : Int -> Int -> Int
numberOfPaths x y =
    factorial (x + y) // factorial x // factorial y


pickGreater : Int -> Int -> Int
pickGreater a b =
    if a > b then
        a
    else
        b


pickLesser : Int -> Int -> Int
pickLesser a b =
    if a > b then
        b
    else
        a


pathfinder : Int -> Int -> List String
pathfinder x y =
    [ "dummy", "string" ]


getFinalPath : Int -> Int -> String
getFinalPath x y =
    let
        onesLength =
            pickGreater x y

        zerosLength =
            pickLesser x y
    in
        padding onesLength "1" ++ padding zerosLength "0"


padding : Int -> String -> String
padding i c =
    if String.length c == i then
        c
    else
        padding i (c ++ String.left 1 c)


generateGrid : Int -> Int -> Html Msg
generateGrid a b =
    List.range 1 a
        |> List.map (\x -> div [ class "row" ] [ makeRow b ])
        |> div []


makeRow : Int -> Html Msg
makeRow b =
    List.range 1 b
        |> List.map (\x -> div [ class "box" ] [ text ("box") ])
        |> div []



--view


view : Model -> Html Msg
view model =
    div []
        [ div [] [ text "Select the dimension of the grid and the number of short paths accross its diagonal will be shown." ]
        , div []
            [ button [ onClick DecreaseX ] [ text "-" ]
            , div [] [ text ("x: " ++ (toString model.xDim)) ]
            , button [ onClick IncreaseX ] [ text "+" ]
            ]
        , div []
            [ button [ onClick DecreaseY ] [ text "-" ]
            , div [] [ text ("y: " ++ (toString model.yDim)) ]
            , button [ onClick IncreaseY ] [ text "+" ]
            ]
        , div [] [ text (toString model.paths) ]
        , div [] [ text model.output ]
        , button [ onClick FindPaths ] [ text "list paths" ]
        , div [] [ model.grid ]
        ]
