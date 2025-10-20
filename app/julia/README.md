export PATH="/opt/julia/bin:$PATH"

source ~/.bashrc

julia -e 'using Pkg; Pkg.add("IJulia")'