<div style="text-align:center">
	<img src="figures/ji_logo.png" alt="Jilogo" style="zoom:60%;" />
</div>
<center>
	<h2>
		VE370 Intro to Computer Organization
	</h2>
</center> 
<center>
	<h3>
		Project 2 - Pipeline Processor
	</h3>
</center>
<center>
   <h4>
       FA 2020
    </h4> 
</center>

------------------------------------------

### Abstract

This project is used to help our VE370 Project 2 team work together. 

Once we open source the code for `20FA VE370 Project 2` and if you want to refer to our work, please follow the Joint Institute’s honor code and don’t plagiarize these codes directly.

### First Stage

**Due Date: 22:00 pm 20/11/4 Wed. **

- Liu Yihua: Complete the first design of state register modules.
- Shen Yang:  Complete the first design of forwording unit module.
- Peng Haotian: Complete the first design of data hazard detection unit module.

### Code Style

**Example**:

```verilog
module instr_mem(instruction, read_addr, reset);
    // define parameters, like word, byte.
    // line means the size of memory.
    parameter word = 32;
    parameter byte = 8;
    parameter line = 42;
    
    // reset is used to initialize the instruction memory.
    input reset;
    input [word - 1:0] read_addr;
    output [word - 1:0] instruction;
    
    // define the instruction memory.
    // 'instruction' is used for output.
    reg [byte - 1:0] mem[4*line - 1:0];
    reg [word - 1:0] instruction;
    
    // Once 'reset' signal is set to 1, the instruction memory will be initialized.
    always @ (reset) begin
        if (reset ==  1'b1) begin
            $readmemb("D:/JI/2020 fall/VE370 Intro to Computer Organization/Projects/P2/InstructionMem_for_P2_Demo.txt", mem);
        end
    end
    
    // Once read address changes, instruction should change correspondingly.
    always @ (read_addr) begin
        instruction = {mem[read_addr], mem[read_addr + 1], mem[read_addr+2], mem[read_addr+3]};
    end
endmodule
```

1. Plz avoid meaningless combination of letters like `a` or `abc` when naming variables. Name of variable should be meaningful. 
2. Plz try to put module parameters such as output variables in the front position.
3. Plz add appropriate indentation and blank lines to your code.
4. Plz add enough comments to help others understand your code.

### Git Usage

Here are some simple instructions about how to use `Git`.

1. If you want to download the whole project, run following command.

```bash
git clone https://github.com/zzp1012/VE370-Project2.git
```

2. If you want add files to our local git project and remote git project on `github`, run following command.

```bash
# Firstly, plz avoid adding files to master branch on github directly. You can create your own branch locally and remotely.

git branch zzp1012 # create my local branch. Here I name the branch as 'zzp1012'. If you have already created a branch, you can jump to next command.

git checkout zzp1012 # switch to 'zzp1012' branch.

git add * # add all the files to local branch 'zzp1012'.

git commit -m "update" # confirm to add files to local branch 'zzp1012'

git push origin zzp1012 # create branch 'zzp1012' remotely on github and copy your the content on your local branch 'zzp1012' to the remote 'zzp1012'.
```

3. If you want to synchronize files on remote project on `github`, you should run:

```bash
git pull origin master # synchronize files on remote master branch.
git pull origin "you branch name" # the 'master' can be replaced by the name of the other branch created on remote project on github, then you can synchronize files on the specific remote branch.
```

### Reference

[1] Zheng, G., 2020. *Ve370 Introduction To Computer Organization Project 2*.

---------------------------------------------------------------

<center>
    UM-SJTU Joint Institute 交大密西根学院
</center>