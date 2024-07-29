local i = 1;
local reverse = false;
local og = script.Parent.Text;
while wait(.16) do
	local dots = string.rep(".",i);
	if(reverse == false) then
		i += 1;
		reverse = (i >= 3);
	elseif(reverse) then
		i = i - 1;
		if(i < 1) then
			reverse = false;
		end
	end
	script.Parent.Text = og .. dots;
end