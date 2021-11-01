module Delaunay

export DelaunayNet, tri_points

using PyCall

const delaunay2D = PyNULL()

function __init__() 
	if haskey(ENV, "XLSXWRITER_PATH")
		pushfirst!(PyVector(pyimport("sys")["path"]), ENV["Delaunay2D"])
		copy!(xlsxwriter, pyimport("delaunay2D"))
	else
		throw("Need to set ENV[\"Delaunay2D\"] to the path where the delaunay2D folder can be found. For me that is: raw\"C:\\Users\\matthew.heath\\repos\\Delaunay.jl\\src\" and reload or call Delaunay.__init__() ")
	end
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
	for i in 1:length(xs)
		dt.addPoint((xs[i], ys[i]))
	end
	map(t->(t[1]+1, t[2]+1, t[3]+1), dt.exportTriangles())
end

function tri_points(tri, xs, ys)
	map(i->xs[tri[i]], 1:3), map(i->ys[tri[i]], 1:3)
end

#####
end
