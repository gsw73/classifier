module svtb_top();
    import class_pkg::*;
    timeunit 1ns/1ps;

    logic clk;
    logic rst_n;

    class_intf u_class_intf(.clk(clk), .rst_n(rst_n));
    main u_main(.sig_h(u_class_intf.TB));
    classifier u_classifier(.clk(clk), .rst_n(rst_n), .clsmp(u_class_intf));

    initial begin
        clk = 1'b1;
        forever #5 clk = ~clk;
    end

    initial begin
        rst_n = 1'b0;
        #101 rst_n = 1'b1;
    end
endmodule : svtb_top

program automatic main
    import class_pkg::*;
    (class_intf.TB sig_h);
    timeunit 1ns/1ps;

    initial begin
        $display("%t program main begin");
        repeat(150) @sig_h.cb;
    end

endprogram : main
