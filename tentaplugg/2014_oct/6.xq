<!--Starting from /Routes/,
list all the arrival times of routes ending in 'stockholm'-->
/Routes/Route[@End='stockholm']/Arrives

<!--Write and XQuery expression starting from
let $root=doc("Routes.xml")
to list all routeID's in the form
<routeID>XX</routeID>
where XX is a single routeID-->

let $root=doc("Routes.xml")
for $route in $root/Routes/Route
return <routeID>{$route/@RouteID}</routeID>


<!-- Write an XQuery expression to list the platform and arrival time of all trains that will stop in 'västerås' in the format
<toVästerås time= "xx:xx" platform="xxxx" />
Sorted by time in ascending order-->

let $root=doc("Routes.xml")
for $stops in $root/Routes/Route/Stop
let $platform = $stops/../Platform
where $stops/Stop[@name = 'västerås']
order $stops/Stop/Time
return <toVästerås time="{$stops/Stop/Time}" platform="{$platform}" />
