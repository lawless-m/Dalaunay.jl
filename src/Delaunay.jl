module Delaunay

export DelaunayNet, tri_points

using PyCall

const delaunay2D = PyNULL()

function __init__() 
	pushfirst!(PyVector(pyimport("sys")["path"]), ".") 
	copy!(delaunay2D, pyimport("delaunay2D"))
end

struct DelaunayNet
	xs
	ys
	net
	function DelaunayNet(xs, ys)
		if delaunay2D == PyNULL()
			__init__()
		end
		new(xs, ys, delaunay2d(xs, ys))
	end
end

function delaunay2d(xs, ys)
	dt = delaunay2D.Delaunay2D()
	for i in 1 length(xs)
		dt.addPoint((xs[i], ys[i]))
	end
	map(t->(t[1]+1, t[2]+1, t[3]+1), dt.exportTriangles())
end

function delaunay2d(xs, ys)
	dt = delaunay2D.Delaunay2D()
	for i in 1 length(xs)
		dt.addPoint((xs[i], ys[i]))
	end
	map(t->(t[1]+1, t[2]+1, t[3]+1), dt.exportTriangles())
end

function tri_points(tri, xs, ys)
	map(i->xs[tri[i]], 1:3), map(i->ys[tri[i]], 1:3)
end

#####
end
