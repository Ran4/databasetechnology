(:Which director has directed at least two movies,
and which movies has he directed?:)
let $nl := "&#10;"

let $videos := doc("videos.xml")/result/videos/video

let $topmovies :=
    for $video in $videos
    order by $video/user_rating descending 
    return $video/title
return subsequence($topmovies, 1, 10)
(:  return concat($nl,$videoTitle) :)
