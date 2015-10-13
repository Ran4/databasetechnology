(:Who have starred in the most distinct types of genre?:)
let $videos := doc("videos.xml")/result/videos/video
let $actorss := doc("videos.xml")/result/actors

let $foo :=
    for $actorid in $actorss/actor/@id
        order by count($videos[actorRef = $actorid]/genre) descending
        return distinct-values($actorss/actor[@id = $actorid])

(:return <actor>{subsequence($foo, 1, 1)}</actor>:)
(:return subsequence($foo, 1, 1):)
return concat('actor="',$foo[1],'"')
