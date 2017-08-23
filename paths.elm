module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)


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
    , output = ""
    }



--update


type Msg
    = IncreaseX
    | DecreaseX
    | IncreaseY
    | DecreaseY
    | GetResult


update : Msg -> Model -> Model
update msg model =
    case msg of
        IncreaseX ->
            { model
                | xDim = increase model.xDim
                , grid = div [] []
                , output = "Press calculate to find out result!"
            }

        DecreaseX ->
            { model
                | xDim = decrease model.xDim
                , grid = div [] []
                , output = "Press calculate to find out result!"
            }

        IncreaseY ->
            { model
                | yDim = increase model.yDim
                , grid = div [] []
                , output = "Press calculate to find out result!"
            }

        DecreaseY ->
            { model
                | yDim = decrease model.yDim
                , grid = div [] []
                , output = "Press calculate to find out result!"
            }

        GetResult ->
            { model
                | grid = generateGrid model.xDim model.yDim
                , output = "There are " ++ toString (numberOfPaths model.xDim model.yDim) ++ " paths accross this lattice!"
            }


decrease : Int -> Int
decrease n =
    if n > 1 then
        n - 1
    else
        n


increase : Int -> Int
increase n =
    if n < 20 then
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
    round (toFloat (factorial (x + y)) / toFloat (factorial x) / toFloat (factorial y))


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
        |> List.map (\x -> div [ class "box" ] [])
        |> div []



--view


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Lattice Paths Solver" ]
        , img [ src "illustration.gif" ] []
        , p [ class "intro" ] [ text "Select the dimension of the lattice and hit Calculate to find the number of unique short paths from one corner to the other." ]
        , div [ class "control" ]
            [ button [ onClick IncreaseX ] [ text "+" ]
            , div [] [ text ("x: " ++ (toString model.xDim)) ]
            , button [ onClick DecreaseX ] [ text "-" ]
            ]
        , div [ class "control" ]
            [ button [ onClick IncreaseY ] [ text "+" ]
            , div [] [ text ("y: " ++ (toString model.yDim)) ]
            , button [ onClick DecreaseY ] [ text "-" ]
            ]
        , button [ onClick GetResult ] [ text "Calculate" ]
        , div [ class "result" ] [ text (model.output) ]
        , div [] [ model.grid ]
        ]
