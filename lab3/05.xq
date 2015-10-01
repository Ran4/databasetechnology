(:Which is one of the highest rating movie starring both Brad Pitt and Morgan
Freeman?:)
let $videos := doc("videos.xml")/result/videos/video
let $id1 := doc("videos.xml")/result/actors/actor[. = "Pitt, Brad"]/@id
let $id2 := doc("videos.xml")/result/actors/actor[. = "Freeman, Morgan"]/@id

(:let $id1 := doc("videos.xml")/result/actors/actor[. = "Jones, Tommy Lee"]/@id:)
(:let $id1 := doc("videos.xml")/result/actors/actor[. = "Ford, Harrison"]/@id:)
(:let $id2 := doc("videos.xml")/result/actors/actor[. = "Ford, Harrison"]/@id:)

let $movieswithspecificactors :=
    for $video in $videos
    order by $video/user_rating descending
    return $video[actorRef = $id1 and actorRef = $id2]/title

return $movieswithspecificactors
