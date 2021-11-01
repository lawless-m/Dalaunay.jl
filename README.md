# Delaunay


to plot a Delaunay net in SVG, try this


using SVG
using Delaunay

d = DelaunayNet(100 .* rand(100), 100 .* rand(100))

write("net.html", Svg(100, 100, map(t->SVG.Polyline(Delaunay.tri_points(t, d.xs, d.ys)...), d.net)), inhtml=true)

