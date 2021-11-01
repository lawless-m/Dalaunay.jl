# Delaunay


to plot a Delaunay net in SVG, try this


using SVG
using Delaunay

d = DelaunayNet(100 .* rand(100), 100 .* rand(100))

write("net.html", Svg(100, 100, map(t->SVG.Polyline(Delaunay.triPoints(t, d.xs, d.ys)..., style=style), d.net)), inhtml=true)

