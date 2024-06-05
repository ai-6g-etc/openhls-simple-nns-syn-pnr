add_files -fileset constrs_1 -norecurse alveo-u280-xdc.xdc
import_files -fileset constrs_1 alveo-u280-xdc.xdc

add_files -norecurse -scan_for_includes linear.sv -force
import_files -norecurse linear.sv -force

add_files -norecurse -scan_for_includes flopoco_relu.sv -force
import_files -norecurse flopoco_relu.sv -force

add_files -norecurse -scan_for_includes flopoco_neg.sv -force
import_files -norecurse flopoco_neg.sv -force

add_files -norecurse -scan_for_includes flopoco_max.sv -force
import_files -norecurse flopoco_max.sv -force

add_files -norecurse -scan_for_includes flopoco_fadd_5_4.sv -force
import_files -norecurse flopoco_fadd_5_4.sv -force

add_files -norecurse -scan_for_includes flopoco_fcmplt_5_4.sv -force
import_files -norecurse flopoco_fcmplt_5_4.sv -force

add_files -norecurse -scan_for_includes flopoco_fsqrt_5_4.sv -force
import_files -norecurse flopoco_fsqrt_5_4.sv -force

add_files -norecurse -scan_for_includes flopoco_fdiv_5_4.sv -force
import_files -norecurse flopoco_fdiv_5_4.sv -force

add_files -norecurse -scan_for_includes flopoco_fmul_5_4.sv -force
import_files -norecurse flopoco_fmul_5_4.sv -force

add_files -norecurse -scan_for_includes flopoco_fsub_5_4.sv -force
import_files -norecurse flopoco_fsub_5_4.sv -force

