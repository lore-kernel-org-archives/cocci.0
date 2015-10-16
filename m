From: linux@rasmusvillemoes.dk (Rasmus Villemoes)
Date: Fri, 16 Oct 2015 23:00:28 +0200
Subject: [Cocci] extremely slow processing of trivial header file
Message-ID: <87a8rio7f7.fsf@rasmusvillemoes.dk>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi

I just ran into a slightly weird case. spatch takes forever handling a
simple header file which contains nothing but #defines.

I tried

  https://github.com/Villemoes/linux-cocci/blob/master/microopt/copy_bit.cocci

on

  drivers/gpu/drm/amd/include/asic_reg/gmc/gmc_8_1_sh_mask.h

With --profile, the first few lines are

$ spatch --include-headers --no-includes --patch . --profile -I arch/x86/include -I arch/x86/include/generated -I include -I arch/x86/include/uapi -I arch/x86/include/generated/uapi -I include/uapi -I include/generated/uapi -I include/linux/kconfig.h -D patch --cocci-file /home/villemoes/projects/linux-cocci/microopt/copy_bit.cocci ./drivers/gpu/drm/amd/include/asic_reg/gmc/gmc_8_1_sh_mask.h
init_defs_builtins: /usr/local/lib/coccinelle/standard.h
HANDLING: ./drivers/gpu/drm/amd/include/asic_reg/gmc/gmc_8_1_sh_mask.h
Note: processing took    41.8s: ./drivers/gpu/drm/amd/include/asic_reg/gmc/gmc_8_1_sh_mask.h
starting: Common.group_assoc_bykey_eff
ending: Common.group_assoc_bykey_eff, 0.000004s
---------------------
profiling result
---------------------
Main total                               :     42.428 sec          1 count
Main.outfiles computation                :     41.845 sec          1 count
full_engine                              :     41.845 sec          1 count
bigloop                                  :     39.998 sec          1 count
process_a_ctl_a_env_a_toplevel           :     39.933 sec      93930 count
mysat                                    :     39.782 sec      93930 count
rule3a                                   :     39.451 sec          1 count

Other headers in drivers/gpu/drm/amd/include/ also take a long time. Any
ideas? I'm using 'spatch version 1.0.2 with Python support and with PCRE
support'.

Rasmus
