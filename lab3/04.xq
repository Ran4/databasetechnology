(:Which actors have starred in the most movies?:)
let $videos := doc("videos.xml")/result/videos/video
let $actorss := doc("videos.xml")/result/actors

let $numofmostcommonactor := max(
    for $actorRef in $actorss/actor/@id
    return count($videos/actorRef[. = data($actorRef)])
)

let $mostcommonactorsrefid :=
    for $actorRef in $actorss/actor/@id
    where count($videos/actorRef[. = data($actorRef)]) = $numofmostcommonactor
    return $actorRef

(:return distinct-values($actorss/actor[@id = $mostcommonactorsrefid]):)
let $mostcommonactornames :=
    distinct-values($actorss/actor[@id = $mostcommonactorsrefid])

for $actorname in $mostcommonactornames
    return concat('actor="', $actorname, '"')
