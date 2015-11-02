<!--let $ids := doc("Bikes.xml")/Bikes/Bike[/Owner="George"]/@id
return $ids-->

let $bikes := doc("Bikes.xml")

for $bike in $bikes/Bike
where $bike/Tire[@type=="Winter"]
return $bikes/Bikeroom[$bike in @bikes]/Address
