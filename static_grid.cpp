// static_grid.cpp

/*
    This file is part of L-Echo.

    L-Echo is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    L-Echo is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with L-Echo.  If not, see <http://www.gnu.org/licenses/>.
*/

#include <iostream>

#include <echo_debug.h>
#include <echo_error.h>
#include <echo_gfx.h>
#include <echo_math.h>
#include <grid.h>
#include <static_grid.h>

static_grid::static_grid() : grid()
{
}
static_grid::static_grid(grid_info_t* my_info, grid* my_prev, grid* my_next, vector3f camera) : grid()
{
	init(my_info, my_prev, my_next, camera);
}
void static_grid::init(grid_info_t* my_info, grid* my_prev, grid* my_next, vector3f camera)
{
#ifdef STRICT_MEM
	grid_info_t* init_info = new(grid_info_t);
	CHKPTR(init_info);
	grid::init(init_info, my_prev, my_next);
#else
	grid::init(new(grid_info_t), my_prev, my_next);
#endif
	real_vec = my_info->pos.neg_rotate_yx(camera);
	force_refresh(camera);
}
void static_grid::refresh(vector3f camera)
{
    if(camera != prev_angle)
    {
        force_refresh(camera);
    }
}

void static_grid::init_to_null()
{
	grid::init_to_null();
	real_vec = NULL;
}

void static_grid::force_refresh(vector3f camera)
{
	ginfo->pos = *(real_vec->rotate_xy(camera));
	lines = generate_lines(*ginfo);
	prev_angle.set(camera);
}

grid_info_t* static_grid::get_info(vector3f angle)
{
	refresh(angle);
	return(ginfo);
}

void static_grid::draw(vector3f angle)
{
	refresh(angle);
	grid::draw(angle);
}

