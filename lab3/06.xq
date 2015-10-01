(:Which actors have starred in the most movies?:)
let $nl := "&#10;"

let $videos := doc("videos.xml")/result/videos/video
let $actorss := doc("videos.xml")/result/actors

let $actorrefs :=
    for $video in $videos
    where $video[rating = "PG-13" and year >= 1997 and year < 2007]
    return $video/actorRef

let $actorswithnames := distinct-values(
    for $actorref in $actorrefs
        return $actorss/actor[@id = $actorref])
return $actorswithnames
