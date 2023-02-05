#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

// Include common routines
#include <verilated.h>

// Include model header, generated from Verilating "top.v"
#include "Vmux42.h"
#include "verilated_vcd_c.h"

#include <nvboard.h>

typedef Vmux42  TOP_TYPE;

static TOP_NAME dut;

VerilatedContext* contextp = NULL;
VerilatedVcdC* tfp = NULL;

static TOP_TYPE* top;

void nvboard_bind_all_pins(TOP_NAME* top);

void step_and_dump_wave(){
    top->X = rand() % 255;
    top->Y = 0;
    top->eval();
    contextp->timeInc(1);
    tfp->dump(contextp->time());

    top->Y = 1;
    top->eval();
    contextp->timeInc(1);
    tfp->dump(contextp->time());

    top->Y = 2;
    top->eval();
    contextp->timeInc(1);
    tfp->dump(contextp->time());

    top->Y = 3;
    top->eval();
    contextp->timeInc(1);
    tfp->dump(contextp->time());

    tfp->close();
}

void step() {
    // printf("X= %d, Y= %d, F= %d\n", dut.X, dut.Y, dut.F);
    dut.eval();
    contextp->timeInc(1);
    tfp->close();
}

void sim_init(){
    nvboard_bind_all_pins(&dut);
    nvboard_init();
    contextp = new VerilatedContext;
    tfp = new VerilatedVcdC;
    top = new TOP_TYPE;
    contextp->traceEverOn(true);
    top->trace(tfp, 0);
    tfp->open("dump.vcd");
}

void sim_exit(){
    tfp->close();
    nvboard_quit();
}

// void reset(int n) {
//   dut.rst = 1;
//   while (n -- > 0) step_and_dump_wave();
//   dut.rst = 0;
// }

int main(int argc, char** argv, char** env) {
    sim_init();

    // reset(10);
    while (!contextp->gotFinish()) {
        step();
        nvboard_update();
    }

    sim_exit();

    return 0;
}