From: vthakkar1994@gmail.com (Vaishali Thakkar)
Date: Tue, 10 Jan 2017 13:48:06 +0530
Subject: [Cocci] [RFC] coccicheck: add a test for repeat memory fetches
In-Reply-To: <alpine.DEB.2.20.1701100900530.1952@hadrien>
References: <20170109231323.GA89642@beast>
 <alpine.DEB.2.20.1701100701250.2185@hadrien>
 <B2ABE526-305B-424A-B257-338E81658DFD@gmail.com>
 <alpine.DEB.2.20.1701100900530.1952@hadrien>
Message-ID: <CAK-LDb+eHNQPQqMFfFjMJySRwpEGJvS13DKpSR1ezA8Qgg4xDw@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, Jan 10, 2017 at 1:31 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
>
>
> On Tue, 10 Jan 2017, Pengfei Wang wrote:
>
>>
>> > ? 2017?1?10????2:06?Julia Lawall <julia.lawall@lip6.fr> ???
>> >
>> >
>> >
>> > On Mon, 9 Jan 2017, Kees Cook wrote:
>> >
>> >> Okay, this adds a few tests, for people to examine.
>> >>
>> >> reusercopy-cook.cocci:
>> >> My original test, with recent updates from Julia.
>> >>
>> >> reusercopy-wang.cocci:
>> >> This is Pengfei's test, but with heavily modified reporting to fit in the
>> >> kernel coccicheck target, and with all the getuser checks removed so that
>> >> Julia's size test could be added (this lets us compare the results between
>> >> this and my original test).
>> >
>> > Thanks for the update.
>> >
>> > I'm not enthusiastic about all the python filtering.  It would be better
>> > to try to put it into the pattern matching rules.
>>
>> I agree with that. I used the python filtering because I could not filter out the false
>> positives with the rules since I was a beginner to Coccinelle. I encourage you to use
>> the pattern matching rules if possible.
>> >
>> > I'm not sure what is the point of func in the various rules.  Is there a
>> > need to ensure that the pattern appears only once in a function definition?
>>
>> It is unnecessary to use the ?func? as long as it won?t cause an error when running the script.
>> I used it because we found that this pattern usually takes place within a function. The pattern
>> is not necessarily to appear only once, and our approach should be able to match multiple
>> occurrences of this pattern within one function.
>>
>> However, our approach currently cannot match an inter-function pattern, within which the two
>> copy operations reside in two functions respectively. The first function copies the user data first,
>> and it calls the second function, then within the second function, the user data is copied again
>> and used. This situation actually exists(CVE-2016-6516), and could cause bad consequences.

Thanks for the inputs on this issue. Indeed finding things under one
function are
obvious cases. /kernel/kexec_core.c was removed from the output because of
that approach. This can be easily done in the reusercopy-cook.cocci as well.

Also, reusercopy-wang.cocci  finds few more cases. I have done few changes in
reusercopy-cook.cocci to cover them in pattern matching rule only so
that we don't
need the whole python rule from reusercopy-wang.cocci. Was supposed to send it
but now that you have mentioned the issue with the inter function
pattern, let me try
to see if we can do that with Coccinelle. As far as it is within a
single file, I think
coccinelle would be able to do that. I'll send my proposed changes
after testing the
inter function pattern.

>> I also suggest adding more copy function APIs, such as strncpy_from_user(). I didn?t do so for
>> two reasons.
>> 1. My script already looks redundant and I?m trying to use a better structure.
>> 2. The other copy functions are not so prevalent as the four I used.
>> But adding more copy functions could make it more accurate.

I'll check about strncpy_from_user once we will have a coccinelle
script in a good shape
for both of these cases.

Thanks!

>> Please feel free to contact me if you have any questions about my script.
>
> Thanks for the feedback!  Indeed Coccinelle is not well adapted to
> interprocedural analysis, but it could be added to a limited extent, eg
> one level of function call if it seems useful, once the rest is in good
> shape.
>
> julia
>
>
>>
>> Regards
>> Pengfei
>>
>> >
>> > I'll look at this in more detail this evening, and try to remove more false
>> > positives.  If you know of some specifically, please let me know what they are.
>> >
>> > thanks,
>> > julia
>> >
>> >
>> >>
>> >> regetuser-wang.cocci:
>> >> This is Pengfei's get_user() tests only (to compare against hits from just
>> >> the copy_from_user() tests).
>> >>
>> >> Comparing reusercopy-cook.cocci with reusercopy-wang.cocci:
>> >> -./arch/ia64/kernel/perfmon.c:4833
>> >> +./arch/powerpc/kernel/signal_32.c:742
>> >> +./arch/powerpc/kernel/signal_32.c:850
>> >> ./arch/powerpc/platforms/powernv/opal-prd.c:248
>> >> ./drivers/acpi/custom_method.c:54
>> >> -./drivers/firmware/efi/test/efi_test.c:617
>> >> -./drivers/hid/hid-picolcd_debugfs.c:283
>> >> +./drivers/gpu/drm/radeon/radeon_cs.c:635
>> >> ./drivers/hwtracing/stm/core.c:580
>> >> ./drivers/isdn/i4l/isdn_ppp.c:875
>> >> ./drivers/md/dm-ioctl.c:1741
>> >> -./drivers/misc/mic/vop/vop_vringh.c:775
>> >> +./drivers/md/md.c:7030
>> >> +./drivers/misc/lkdtm_usercopy.c:106
>> >> +./drivers/misc/lkdtm_usercopy.c:160
>> >> +./drivers/misc/lkdtm_usercopy.c:232
>> >> ./drivers/misc/mic/vop/vop_vringh.c:944
>> >> +./drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c:2159
>> >> +./drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c:2257
>> >> +./drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c:2302
>> >> +./drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c:2342
>> >> +./drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c:2365
>> >> +./drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c:2406
>> >> +./drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c:2439
>> >> +./drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c:2491
>> >> +./drivers/net/hamradio/yam.c:981
>> >> +./drivers/net/hamradio/yam.c:997
>> >> +./drivers/net/tun.c:2021
>> >> +./drivers/net/tun.c:2152
>> >> +./drivers/net/tun.c:2168
>> >> +./drivers/net/tun.c:2211
>> >> ./drivers/platform/chrome/cros_ec_dev.c:185
>> >> ./drivers/scsi/3w-9xxx.c:688
>> >> ./drivers/scsi/3w-sas.c:761
>> >> ./drivers/scsi/3w-xxxx.c:920
>> >> ./drivers/scsi/aacraid/commctrl.c:117
>> >> ./drivers/scsi/megaraid.c:3465
>> >> +./drivers/scsi/mpt3sas/mpt3sas_ctl.c:2309
>> >> +./drivers/scsi/sg.c:422
>> >> ./drivers/staging/lustre/lustre/llite/llite_lib.c:2491
>> >> -./kernel/kexec_core.c:775
>> >> -./kernel/kexec_core.c:838
>> >> +./lib/test_kasan.c:401
>> >> +./net/wireless/wext-core.c:809
>> >>
>> >> So, a couple false positives (kernel/kexec_core.c) are detected and ignored
>> >> with the larger test.
>> >>
>> >> And the getuser-only test shows:
>> >>
>> >> ./arch/frv/kernel/traps.c:145
>> >> ./arch/frv/kernel/traps.c:171
>> >> ./arch/frv/kernel/traps.c:194
>> >> ./arch/frv/kernel/traps.c:218
>> >> ./arch/frv/kernel/traps.c:242
>> >> ./arch/frv/kernel/traps.c:266
>> >> ./arch/frv/kernel/traps.c:290
>> >> ./arch/mips/kernel/traps.c:1138
>> >> ./arch/powerpc/kernel/signal_32.c:1196
>> >> ./drivers/staging/rtl8712/rtl871x_ioctl_linux.c:1842
>> >> ./net/compat.c:167
>> >> ./net/decnet/af_decnet.c:1586
>> >> ./net/ipv4/tcp.c:2921
>> >> ./net/ipv4/tcp.c:2939
>> >> ./net/ipv4/tcp.c:2958
>> >> ./net/ipv4/tcp.c:2988
>> >> ./net/ipv4/tcp.c:3034
>> >> ./sound/oss/swarm_cs4297a.c:1472
>> >>
>> >> I've been running them with:
>> >>
>> >> make coccicheck V=1 COCCI=scripts/coccinelle/$name.cocci MODE=report
>> >>
>> >> Regardless, this is still a pretty noise set of tests...
>> >>
>> >> Signed-off-by: Kees Cook <keescook@chromium.org>
>> >> ---
>> >> scripts/coccinelle/tests/regetuser-wang.cocci  | 391 +++++++++++++++++++++++++
>> >> scripts/coccinelle/tests/reusercopy-cook.cocci |  49 ++++
>> >> scripts/coccinelle/tests/reusercopy-wang.cocci | 389 ++++++++++++++++++++++++
>> >> 3 files changed, 829 insertions(+)
>> >> create mode 100644 scripts/coccinelle/tests/regetuser-wang.cocci
>> >> create mode 100644 scripts/coccinelle/tests/reusercopy-cook.cocci
>> >> create mode 100644 scripts/coccinelle/tests/reusercopy-wang.cocci
>> >>
>> >> diff --git a/scripts/coccinelle/tests/regetuser-wang.cocci b/scripts/coccinelle/tests/regetuser-wang.cocci
>> >> new file mode 100644
>> >> index 000000000000..529232089e91
>> >> --- /dev/null
>> >> +++ b/scripts/coccinelle/tests/regetuser-wang.cocci
>> >> @@ -0,0 +1,391 @@
>> >> +/// Recopying from the same user buffer frequently indicates a pattern of
>> >> +/// Reading a size header, allocating, and then re-reading an entire
>> >> +/// structure. If the structure's size is not re-validated, this can lead
>> >> +/// to structure or data size confusions.
>> >> +///
>> >> +// Confidence: Moderate
>> >> +// Copyright: (C) 2013 Kees Cook, Chromium.
>> >> +// Copyright: (C) 2016 Pengfei Wang.
>> >> +// License: GPLv2.
>> >> +// URL: http://coccinelle.lip6.fr/
>> >> +// Comments:
>> >> +// Options: --no-includes --include-headers
>> >> +
>> >> +virtual report
>> >> +virtual org
>> >> +virtual context
>> >> +
>> >> + at initialize:python@
>> >> +@@
>> >> +# -------------------------Post Matching Process--------------------------
>> >> +def post_match_process(rule,p1,p2,src,ptr):
>> >> +  filename = p1[0].file
>> >> +  first = int(p1[0].line)
>> >> +  second = int(p2[0].line)
>> >> +
>> >> +  src_str = str(src)
>> >> +  ptr_str = str(ptr)
>> >> +  #print "src1:", src_str
>> >> +  #print "src2:", ptr_str
>> >> +  #print "first:", first
>> >> +  #print "second:", second
>> >> +
>> >> +  # Remove loop case, first and second fetch are not supposed to be
>> >> +  # in the same line.
>> >> +  if first == second:
>> >> +          return
>> >> +
>> >> +  # Remove reverse loop case, where first fetch behind second fetch
>> >> +  # but in last loop .
>> >> +  if first > second:
>> >> +          return
>> >> +
>> >> +  # Remove case of get_user(a, src++) or get_user(a, src + 4)
>> >> +  if src_str.find("+") != -1 or ptr_str.find("+") != -1:
>> >> +          return
>> >> +
>> >> +  # Remove case of get_user(a, src[i])
>> >> +  if src_str.find("[") != -1 or ptr_str.find("[") != -1:
>> >> +          return
>> >> +
>> >> +  # Remove case of get_user(a, src--) or get_user(a, src - 4)
>> >> +  if src_str.find("-") != -1 and src_str.find("->") == -1:
>> >> +          return
>> >> +  if ptr_str.find("-") != -1 and ptr_str.find("->") == -1:
>> >> +          return
>> >> +
>> >> +  # Remove false matching of src ===> (int*)src , but leave
>> >> +  # function call like u64_to_uptr(ctl_sccb.sccb)
>> >> +  if src_str.find("(") == 0 or ptr_str.find("(") == 0:
>> >> +          return
>> >> +
>> >> +  coccilib.report.print_report(p2[0],
>> >> +          "potentially dangerous second get_user() (rule %d: line %d vs line %d)" %
>> >> +                  (rule, first, second))
>> >> +
>> >> +
>> >> +//-----------------Pattern Matching Rules-----------------------------------
>> >> +//------------------------------- case 1: normal case without src assignment
>> >> +@ rule1 disable drop_cast exists @
>> >> +expression addr,exp1,exp2,src,offset;
>> >> +position p1,p2;
>> >> +identifier func;
>> >> +type T1,T2;
>> >> +@@
>> >> +  func(...){
>> >> +  ...
>> >> +(
>> >> +  get_user(exp1, (T1)src)@p1
>> >> +|
>> >> +  get_user(exp1, src)@p1
>> >> +|
>> >> +  __get_user(exp1, (T1)src)@p1
>> >> +|
>> >> +  __get_user(exp1, src)@p1
>> >> +)
>> >> +  ...     when any
>> >> +          when != src = addr
>> >> +          when != src ++
>> >> +          when != src --
>> >> +          when != src += offset
>> >> +          when != src -= offset
>> >> +          when != src = src + offset
>> >> +          when != src = src - offset
>> >> +
>> >> +(
>> >> +  get_user(exp2, (T2)src)@p2
>> >> +|
>> >> +  get_user(exp2, src)@p2
>> >> +|
>> >> +  __get_user(exp2,(T2)src)@p2
>> >> +|
>> >> +  __get_user(exp2, src)@p2
>> >> +)
>> >> +  ...
>> >> +  }
>> >> +
>> >> + at script:python depends on report@
>> >> +p11 << rule1.p1;
>> >> +p12 << rule1.p2;
>> >> +s1 << rule1.src;
>> >> +@@
>> >> +
>> >> +if p11 and p12:
>> >> +  post_match_process(1, p11, p12, s1, s1)
>> >> +
>> >> +//----------------------------------- case 2: ptr = src at beginning, ptr first
>> >> +@ rule2 disable drop_cast exists @
>> >> +identifier func;
>> >> +expression addr,exp1,exp2,src,ptr,offset;
>> >> +position p0,p1,p2;
>> >> +type T0,T1,T2;
>> >> +@@
>> >> +
>> >> +
>> >> +  func(...){
>> >> +  ...
>> >> +(
>> >> +  ptr = (T0)src at p0 // potential assignment case
>> >> +|
>> >> +  ptr = src at p0
>> >> +)
>> >> +  ...
>> >> +(
>> >> +  get_user(exp1, (T1)ptr)@p1
>> >> +|
>> >> +  get_user(exp1, ptr)@p1
>> >> +|
>> >> +  __get_user(exp1, (T1)ptr)@p1
>> >> +|
>> >> +  __get_user(exp1, ptr)@p1
>> >> +)
>> >> +  ...
>> >> +          when != src = addr
>> >> +          when != src ++
>> >> +          when != src --
>> >> +          when != src += offset
>> >> +          when != src -= offset
>> >> +          when != src = src + offset
>> >> +          when != src = src - offset
>> >> +(
>> >> +  get_user(exp2, (T2)src)@p2
>> >> +|
>> >> +  get_user(exp2, src)@p2
>> >> +|
>> >> +  __get_user(exp2,(T2)src)@p2
>> >> +|
>> >> +  __get_user(exp2, src)@p2
>> >> +)
>> >> +  ...
>> >> +  }
>> >> +
>> >> + at script:python depends on report@
>> >> +p21 << rule2.p1;
>> >> +p22 << rule2.p2;
>> >> +p2 << rule2.ptr;
>> >> +s2 << rule2.src;
>> >> +@@
>> >> +if p21 and p22:
>> >> +  post_match_process(2, p21, p22, s2, p2)
>> >> +//------------------------- case 3: ptr = src at beginning, src first
>> >> +@ rule3 disable drop_cast exists @
>> >> +identifier func;
>> >> +expression addr,exp1,exp2,src,ptr,offset;
>> >> +position p0,p1,p2;
>> >> +type T0,T1,T2;
>> >> +@@
>> >> +
>> >> +
>> >> +  func(...){
>> >> +  ...
>> >> +(
>> >> +  ptr = (T0)src at p0 // potential assignment case
>> >> +|
>> >> +  ptr = src at p0
>> >> +)
>> >> +  ...
>> >> +(
>> >> +  get_user(exp1, (T1)src)@p1
>> >> +|
>> >> +  get_user(exp1, src)@p1
>> >> +|
>> >> +  __get_user(exp1, (T1)src)@p1
>> >> +|
>> >> +  __get_user(exp1, src)@p1
>> >> +)
>> >> +  ...
>> >> +          when != src = addr
>> >> +          when != src ++
>> >> +          when != src --
>> >> +          when != src += offset
>> >> +          when != src -= offset
>> >> +          when != src = src + offset
>> >> +          when != src = src - offset
>> >> +(
>> >> +  get_user(exp2, (T2)ptr)@p2
>> >> +|
>> >> +  get_user(exp2, ptr)@p2
>> >> +|
>> >> +  __get_user(exp2,(T2)ptr)@p2
>> >> +|
>> >> +  __get_user(exp2, ptr)@p2
>> >> +)
>> >> +  ...
>> >> +  }
>> >> +
>> >> + at script:python depends on report@
>> >> +p31 << rule3.p1;
>> >> +p32 << rule3.p2;
>> >> +p3 << rule3.ptr;
>> >> +s3 << rule3.src;
>> >> +@@
>> >> +if p31 and p32:
>> >> +  post_match_process(3, p31, p32, s3, p3)
>> >> +//----------------------------------- case 4: ptr = src at middle
>> >> +
>> >> +@ rule4 disable drop_cast exists @
>> >> +identifier func;
>> >> +expression addr,exp1,exp2,src,ptr,offset;
>> >> +position p0,p1,p2;
>> >> +type T0,T1,T2;
>> >> +@@
>> >> +
>> >> +
>> >> +  func(...){
>> >> +  ...
>> >> +(
>> >> +  get_user(exp1, (T1)src)@p1
>> >> +|
>> >> +  get_user(exp1, src)@p1
>> >> +|
>> >> +  __get_user(exp1, (T1)src)@p1
>> >> +|
>> >> +  __get_user(exp1, src)@p1
>> >> +)
>> >> +  ...
>> >> +          when != src = addr
>> >> +          when != src ++
>> >> +          when != src --
>> >> +          when != src += offset
>> >> +          when != src -= offset
>> >> +          when != src = src + offset
>> >> +          when != src = src - offset
>> >> +
>> >> +(
>> >> +  ptr = (T0)src at p0 // potential assignment case
>> >> +|
>> >> +  ptr = src at p0
>> >> +)
>> >> +  ...
>> >> +          when != ptr = addr
>> >> +          when != ptr ++
>> >> +          when != ptr --
>> >> +          when != ptr += offset
>> >> +          when != ptr -= offset
>> >> +          when != ptr = ptr + offset
>> >> +          when != ptr = ptr - offset
>> >> +
>> >> +(
>> >> +  get_user(exp2, (T2)ptr)@p2
>> >> +|
>> >> +  get_user(exp2, ptr)@p2
>> >> +|
>> >> +  __get_user(exp2,(T2)ptr)@p2
>> >> +|
>> >> +  __get_user(exp2, ptr)@p2
>> >> +)
>> >> +  ...
>> >> +  }
>> >> +
>> >> + at script:python depends on report@
>> >> +p41 << rule4.p1;
>> >> +p42 << rule4.p2;
>> >> +p4 << rule4.ptr;
>> >> +s4 << rule4.src;
>> >> +@@
>> >> +if p41 and p42:
>> >> +  post_match_process(4, p41, p42, s4, p4)
>> >> +//----------------------------------- case 5: first element, then ptr, copy from structure
>> >> +@ rule5 disable drop_cast exists @
>> >> +identifier func, f1;
>> >> +expression addr,exp1,exp2,src,offset;
>> >> +position p1,p2;
>> >> +type T1,T2;
>> >> +@@
>> >> +
>> >> +
>> >> +  func(...){
>> >> +  ...
>> >> +(
>> >> +  get_user(exp1, (T1)src->f1)@p1
>> >> +|
>> >> +  get_user(exp1, src->f1)@p1
>> >> +|
>> >> +  get_user(exp1, &(src->f1))@p1
>> >> +|
>> >> +  __get_user(exp1, (T1)src->f1)@p1
>> >> +|
>> >> +  __get_user(exp1, src->f1)@p1
>> >> +|
>> >> +  __get_user(exp1, &(src->f1))@p1
>> >> +)
>> >> +  ...
>> >> +          when != src = addr
>> >> +          when != src ++
>> >> +          when != src --
>> >> +          when != src += offset
>> >> +          when != src -= offset
>> >> +          when != src = src + offset
>> >> +          when != src = src - offset
>> >> +(
>> >> +  get_user(exp2,(T2)src)@p2
>> >> +|
>> >> +  get_user(exp2,src)@p2
>> >> +|
>> >> +  __get_user(exp2,(T2)src)@p2
>> >> +|
>> >> +  __get_user(exp2,src)@p2
>> >> +)
>> >> +  ...
>> >> +  }
>> >> +
>> >> + at script:python depends on report@
>> >> +p51 << rule5.p1;
>> >> +p52 << rule5.p2;
>> >> +s5 << rule5.src;
>> >> +e5 << rule5.f1;
>> >> +@@
>> >> +if p51 and p52:
>> >> +  post_match_process(5, p51, p52, s5, e5)
>> >> +
>> >> +
>> >> +//---------------------- case 6: first element, then ptr, copy from pointer
>> >> +@ rule6 disable drop_cast exists @
>> >> +identifier func, f1;
>> >> +expression addr,exp1,exp2,src,offset;
>> >> +position p1,p2;
>> >> +type T1,T2;
>> >> +@@
>> >> +  func(...){
>> >> +  ...
>> >> +(
>> >> +  get_user(exp1, (T1)src.f1)@p1
>> >> +|
>> >> +  get_user(exp1, src.f1)@p1
>> >> +|
>> >> +  get_user(exp1, &(src.f1))@p1
>> >> +|
>> >> +  __get_user(exp1, (T1)src.f1)@p1
>> >> +|
>> >> +  __get_user(exp1, src.f1)@p1
>> >> +|
>> >> +  __get_user(exp1, &(src.f1))@p1
>> >> +)
>> >> +  ...
>> >> +          when != &src = addr
>> >> +          when != &src ++
>> >> +          when != &src --
>> >> +          when != &src += offset
>> >> +          when != &src -= offset
>> >> +          when != &src = &src + offset
>> >> +          when != &src = &src - offset
>> >> +(
>> >> +  get_user(exp2,(T2)&src)@p2
>> >> +|
>> >> +  get_user(exp2,&src)@p2
>> >> +|
>> >> +  __get_user(exp2,(T2)&src)@p2
>> >> +|
>> >> +  __get_user(exp2,&src)@p2
>> >> +)
>> >> +  ...
>> >> +  }
>> >> +
>> >> + at script:python depends on report@
>> >> +p61 << rule6.p1;
>> >> +p62 << rule6.p2;
>> >> +s6 << rule6.src;
>> >> +e6 << rule6.f1;
>> >> +@@
>> >> +if p61 and p62:
>> >> +  post_match_process(6, p61, p62, s6, e6)
>> >> diff --git a/scripts/coccinelle/tests/reusercopy-cook.cocci b/scripts/coccinelle/tests/reusercopy-cook.cocci
>> >> new file mode 100644
>> >> index 000000000000..b0a71f95bdbf
>> >> --- /dev/null
>> >> +++ b/scripts/coccinelle/tests/reusercopy-cook.cocci
>> >> @@ -0,0 +1,49 @@
>> >> +/// Recopying from the same user buffer frequently indicates a pattern of
>> >> +/// Reading a size header, allocating, and then re-reading an entire
>> >> +/// structure. If the structure's size is not re-validated, this can lead
>> >> +/// to structure or data size confusions.
>> >> +///
>> >> +// Confidence: Moderate
>> >> +// Copyright: (C) 2013 Kees Cook, Chromium.  GPLv2.
>> >> +// URL: http://coccinelle.lip6.fr/
>> >> +// Comments:
>> >> +// Options: --no-includes --include-headers
>> >> +
>> >> +virtual report
>> >> +virtual org
>> >> +virtual context
>> >> +
>> >> + at ok@
>> >> +position p;
>> >> +expression src,dest;
>> >> +@@
>> >> +
>> >> +copy_from_user at p(&dest, src, sizeof(dest))
>> >> +
>> >> + at cfu_twice@
>> >> +position p != ok.p;
>> >> +identifier src;
>> >> +expression dest1, dest2, size1, size2, offset, e1, e2;
>> >> +@@
>> >> +
>> >> +*copy_from_user(dest1, src, size1)
>> >> + ... when != src = offset
>> >> +     when != src += offset
>> >> +     when != src -= offset
>> >> +     when != src ++
>> >> +     when != src --
>> >> +     when != if (size2 > e1 || ...) { ... return ...; }
>> >> +     when != if (size2 > e1 || ...) { ... size2 = e2 ... }
>> >> +*copy_from_user at p(dest2, src, size2)
>> >> +
>> >> + at script:python depends on org@
>> >> +p << cfu_twice.p;
>> >> +@@
>> >> +
>> >> +cocci.print_main("potentially dangerous second copy_from_user()",p)
>> >> +
>> >> + at script:python depends on report@
>> >> +p << cfu_twice.p;
>> >> +@@
>> >> +
>> >> +coccilib.report.print_report(p[0],"potentially dangerous second copy_from_user()")
>> >> diff --git a/scripts/coccinelle/tests/reusercopy-wang.cocci b/scripts/coccinelle/tests/reusercopy-wang.cocci
>> >> new file mode 100644
>> >> index 000000000000..f57a1d997882
>> >> --- /dev/null
>> >> +++ b/scripts/coccinelle/tests/reusercopy-wang.cocci
>> >> @@ -0,0 +1,389 @@
>> >> +/// Recopying from the same user buffer frequently indicates a pattern of
>> >> +/// reading a size header, allocating, and then re-reading an entire
>> >> +/// structure. If the structure's size is not re-validated, this can lead
>> >> +/// to structure or data size confusions.
>> >> +///
>> >> +// Confidence: Moderate
>> >> +// Copyright: (C) 2013 Kees Cook, Chromium.
>> >> +// Copyright: (C) 2016 Pengfei Wang.
>> >> +// License: GPLv2.
>> >> +// URL: http://coccinelle.lip6.fr/
>> >> +// Comments:
>> >> +// Options: --no-includes --include-headers
>> >> +
>> >> +virtual report
>> >> +virtual org
>> >> +virtual context
>> >> +
>> >> + at initialize:python@
>> >> +@@
>> >> +# -------------------------Post Matching Process--------------------------
>> >> +def post_match_process(rule,p1,p2,src,ptr):
>> >> +  filename = p1[0].file
>> >> +  first = int(p1[0].line)
>> >> +  second = int(p2[0].line)
>> >> +
>> >> +  src_str = str(src)
>> >> +  ptr_str = str(ptr)
>> >> +
>> >> +  # Remove loop case, first and second fetch are not supposed to be
>> >> +  # in the same line.
>> >> +  if first == second:
>> >> +          return
>> >> +
>> >> +  # Remove reverse loop case, where first fetch behind second fetch
>> >> +  # but in last loop .
>> >> +  if first > second:
>> >> +          return
>> >> +
>> >> +  # Remove false matching of src ===> (int*)src , but leave
>> >> +  # function call like u64_to_uptr(ctl_sccb.sccb)
>> >> +  if src_str.find("(") == 0 or ptr_str.find("(") == 0:
>> >> +          return
>> >> +
>> >> +  coccilib.report.print_report(p2[0],
>> >> +          "potentially dangerous second copy_from_user() (rule %d: line %d vs line %d)" %
>> >> +                  (rule, first, second))
>> >> +
>> >> +
>> >> +//-----------------Pattern Matching Rules-----------------------------------
>> >> +//------------------------------- case 1: normal case without src assignment
>> >> +@ rule1 disable drop_cast exists @
>> >> +expression addr,exp1,exp2,src,size1,size2,offset,e1,e2;
>> >> +position p1,p2;
>> >> +identifier func;
>> >> +type T1,T2;
>> >> +@@
>> >> +  func(...){
>> >> +  ...
>> >> +(
>> >> +  copy_from_user(exp1, (T1)src, size1)@p1
>> >> +|
>> >> +  copy_from_user(exp1, src, size1)@p1
>> >> +|
>> >> +  __copy_from_user(exp1, (T1)src, size1)@p1
>> >> +|
>> >> +  __copy_from_user(exp1, src, size1)@p1
>> >> +
>> >> +)
>> >> +  ...     when any
>> >> +          when != src = addr
>> >> +          when != src ++
>> >> +          when != src --
>> >> +          when != src += offset
>> >> +          when != src -= offset
>> >> +          when != src = src + offset
>> >> +          when != src = src - offset
>> >> +          when != if (size2 > e1 || ...) { ... return ...; }
>> >> +          when != if (size2 > e1 || ...) { ... size2 = e2 ... }
>> >> +
>> >> +(
>> >> +  __copy_from_user(exp2,(T2)src,size2)@p2
>> >> +|
>> >> +  __copy_from_user(exp2, src,size2)@p2
>> >> +|
>> >> +  copy_from_user(exp2,(T2)src,size2)@p2
>> >> +|
>> >> +  copy_from_user(exp2, src,size2)@p2
>> >> +)
>> >> +  ...
>> >> +  }
>> >> +
>> >> + at script:python depends on report@
>> >> +p11 << rule1.p1;
>> >> +p12 << rule1.p2;
>> >> +s1 << rule1.src;
>> >> +@@
>> >> +
>> >> +if p11 and p12:
>> >> +  post_match_process(1, p11, p12, s1, s1)
>> >> +
>> >> +//------------------------------ case 2: ptr = src at beginning, ptr first
>> >> +@ rule2 disable drop_cast exists @
>> >> +identifier func;
>> >> +expression addr,exp1,exp2,src,ptr,size1,size2,offset,e1,e2;
>> >> +position p0,p1,p2;
>> >> +type T0,T1,T2;
>> >> +@@
>> >> +
>> >> +
>> >> +  func(...){
>> >> +  ...
>> >> +(
>> >> +  ptr = (T0)src at p0 // potential assignment case
>> >> +|
>> >> +  ptr = src at p0
>> >> +)
>> >> +  ...
>> >> +(
>> >> +  copy_from_user(exp1, (T1)ptr,size1)@p1
>> >> +|
>> >> +  copy_from_user(exp1, ptr,size1)@p1
>> >> +|
>> >> +  __copy_from_user(exp1, (T1)ptr,size1)@p1
>> >> +|
>> >> +  __copy_from_user(exp1, ptr,size1)@p1
>> >> +)
>> >> +  ...
>> >> +          when != src = addr
>> >> +          when != src ++
>> >> +          when != src --
>> >> +          when != src += offset
>> >> +          when != src -= offset
>> >> +          when != src = src + offset
>> >> +          when != src = src - offset
>> >> +          when != if (size2 > e1 || ...) { ... return ...; }
>> >> +          when != if (size2 > e1 || ...) { ... size2 = e2 ... }
>> >> +(
>> >> +  __copy_from_user(exp2,(T2)src,size2)@p2
>> >> +|
>> >> +  __copy_from_user(exp2, src,size2)@p2
>> >> +|
>> >> +  copy_from_user(exp2,(T2)src,size2)@p2
>> >> +|
>> >> +  copy_from_user(exp2, src,size2)@p2
>> >> +)
>> >> +  ...
>> >> +  }
>> >> +
>> >> + at script:python depends on report@
>> >> +p21 << rule2.p1;
>> >> +p22 << rule2.p2;
>> >> +p2 << rule2.ptr;
>> >> +s2 << rule2.src;
>> >> +@@
>> >> +if p21 and p22:
>> >> +  post_match_process(2, p21, p22, s2, p2)
>> >> +//------------------------- case 3: ptr = src at beginning, src first
>> >> +@ rule3 disable drop_cast exists @
>> >> +identifier func;
>> >> +expression addr,exp1,exp2,src,ptr,size1,size2,offset,e1,e2;
>> >> +position p0,p1,p2;
>> >> +type T0,T1,T2;
>> >> +@@
>> >> +
>> >> +
>> >> +  func(...){
>> >> +  ...
>> >> +(
>> >> +  ptr = (T0)src at p0 // potential assignment case
>> >> +|
>> >> +  ptr = src at p0
>> >> +)
>> >> +  ...
>> >> +(
>> >> +  copy_from_user(exp1, (T1)src,size1)@p1
>> >> +|
>> >> +  copy_from_user(exp1, src,size1)@p1
>> >> +|
>> >> +  __copy_from_user(exp1, (T1)src,size1)@p1
>> >> +|
>> >> +  __copy_from_user(exp1, src,size1)@p1
>> >> +)
>> >> +  ...
>> >> +          when != src = addr
>> >> +          when != src ++
>> >> +          when != src --
>> >> +          when != src += offset
>> >> +          when != src -= offset
>> >> +          when != src = src + offset
>> >> +          when != src = src - offset
>> >> +          when != if (size2 > e1 || ...) { ... return ...; }
>> >> +          when != if (size2 > e1 || ...) { ... size2 = e2 ... }
>> >> +(
>> >> +  __copy_from_user(exp2,(T2)ptr,size2)@p2
>> >> +|
>> >> +  __copy_from_user(exp2, ptr,size2)@p2
>> >> +|
>> >> +  copy_from_user(exp2,(T2)ptr,size2)@p2
>> >> +|
>> >> +  copy_from_user(exp2, ptr,size2)@p2
>> >> +)
>> >> +  ...
>> >> +  }
>> >> +
>> >> + at script:python depends on report@
>> >> +p31 << rule3.p1;
>> >> +p32 << rule3.p2;
>> >> +p3 << rule3.ptr;
>> >> +s3 << rule3.src;
>> >> +@@
>> >> +if p31 and p32:
>> >> +  post_match_process(3, p31, p32, s3, p3)
>> >> +//----------------------------------- case 4: ptr = src at middle
>> >> +
>> >> +@ rule4 disable drop_cast exists @
>> >> +identifier func;
>> >> +expression addr,exp1,exp2,src,ptr,size1,size2,offset,e1,e2;
>> >> +position p0,p1,p2;
>> >> +type T0,T1,T2;
>> >> +@@
>> >> +
>> >> +
>> >> +  func(...){
>> >> +  ...
>> >> +(
>> >> +  copy_from_user(exp1, (T1)src,size1)@p1
>> >> +|
>> >> +  copy_from_user(exp1, src,size1)@p1
>> >> +|
>> >> +  __copy_from_user(exp1, (T1)src,size1)@p1
>> >> +|
>> >> +  __copy_from_user(exp1, src,size1)@p1
>> >> +)
>> >> +  ...
>> >> +          when != src = addr
>> >> +          when != src ++
>> >> +          when != src --
>> >> +          when != src += offset
>> >> +          when != src -= offset
>> >> +          when != src = src + offset
>> >> +          when != src = src - offset
>> >> +          when != if (size2 > e1 || ...) { ... return ...; }
>> >> +          when != if (size2 > e1 || ...) { ... size2 = e2 ... }
>> >> +
>> >> +(
>> >> +  ptr = (T0)src at p0 // potential assignment case
>> >> +|
>> >> +  ptr = src at p0
>> >> +)
>> >> +  ...
>> >> +          when != ptr = addr
>> >> +          when != ptr ++
>> >> +          when != ptr --
>> >> +          when != ptr += offset
>> >> +          when != ptr -= offset
>> >> +          when != ptr = ptr + offset
>> >> +          when != ptr = ptr - offset
>> >> +          when != if (size2 > e1 || ...) { ... return ...; }
>> >> +          when != if (size2 > e1 || ...) { ... size2 = e2 ... }
>> >> +
>> >> +(
>> >> +  __copy_from_user(exp2,(T2)ptr,size2)@p2
>> >> +|
>> >> +  __copy_from_user(exp2, ptr,size2)@p2
>> >> +|
>> >> +  copy_from_user(exp2,(T2)ptr,size2)@p2
>> >> +|
>> >> +  copy_from_user(exp2, ptr,size2)@p2
>> >> +)
>> >> +  ...
>> >> +  }
>> >> +
>> >> + at script:python depends on report@
>> >> +p41 << rule4.p1;
>> >> +p42 << rule4.p2;
>> >> +p4 << rule4.ptr;
>> >> +s4 << rule4.src;
>> >> +@@
>> >> +if p41 and p42:
>> >> +  post_match_process(4, p41, p42, s4, p4)
>> >> +
>> >> +//-------------------- case 5: first element, then ptr, copy from structure
>> >> +@ rule5 disable drop_cast exists @
>> >> +identifier func, f1;
>> >> +expression addr,exp1,exp2,src,size1,size2,offset,e1,e2;
>> >> +position p1,p2;
>> >> +type T1,T2;
>> >> +@@
>> >> +
>> >> +
>> >> +  func(...){
>> >> +  ...
>> >> +(
>> >> +  copy_from_user(exp1, (T1)src->f1,size1)@p1
>> >> +|
>> >> +  copy_from_user(exp1, src->f1,size1)@p1
>> >> +|
>> >> +  copy_from_user(exp1, &(src->f1),size1)@p1
>> >> +|
>> >> +  __copy_from_user(exp1, (T1)src->f1,size1)@p1
>> >> +|
>> >> +  __copy_from_user(exp1, src->f1,size1)@p1
>> >> +|
>> >> +  __copy_from_user(exp1, &(src->f1),size1)@p1
>> >> +)
>> >> +  ...
>> >> +          when != src = addr
>> >> +          when != src ++
>> >> +          when != src --
>> >> +          when != src += offset
>> >> +          when != src -= offset
>> >> +          when != src = src + offset
>> >> +          when != src = src - offset
>> >> +          when != if (size2 > e1 || ...) { ... return ...; }
>> >> +          when != if (size2 > e1 || ...) { ... size2 = e2 ... }
>> >> +(
>> >> +  __copy_from_user(exp2,(T2)src,size2)@p2
>> >> +|
>> >> +  __copy_from_user(exp2,src,size2)@p2
>> >> +|
>> >> +  copy_from_user(exp2,(T2)src,size2)@p2
>> >> +|
>> >> +  copy_from_user(exp2,src,size2)@p2
>> >> +)
>> >> +  ...
>> >> +  }
>> >> +
>> >> + at script:python depends on report@
>> >> +p51 << rule5.p1;
>> >> +p52 << rule5.p2;
>> >> +s5 << rule5.src;
>> >> +e5 << rule5.f1;
>> >> +@@
>> >> +if p51 and p52:
>> >> +  post_match_process(5, p51, p52, s5, e5)
>> >> +
>> >> +
>> >> +//---------------------- case 6: first element, then ptr, copy from pointer
>> >> +@ rule6 disable drop_cast exists @
>> >> +identifier func, f1;
>> >> +expression addr,exp1,exp2,src,size1,size2,offset,e1,e2;
>> >> +position p1,p2;
>> >> +type T1,T2;
>> >> +@@
>> >> +  func(...){
>> >> +  ...
>> >> +(
>> >> +  copy_from_user(exp1, (T1)src.f1, size1)@p1
>> >> +|
>> >> +  copy_from_user(exp1, src.f1, size1)@p1
>> >> +|
>> >> +  copy_from_user(exp1, &(src.f1), size1)@p1
>> >> +|
>> >> +  __copy_from_user(exp1, (T1)src.f1, size1)@p1
>> >> +|
>> >> +  __copy_from_user(exp1, src.f1, size1)@p1
>> >> +|
>> >> +  __copy_from_user(exp1, &(src.f1), size1)@p1
>> >> +)
>> >> +  ...
>> >> +          when != &src = addr
>> >> +          when != &src ++
>> >> +          when != &src --
>> >> +          when != &src += offset
>> >> +          when != &src -= offset
>> >> +          when != &src = &src + offset
>> >> +          when != &src = &src - offset
>> >> +          when != if (size2 > e1 || ...) { ... return ...; }
>> >> +          when != if (size2 > e1 || ...) { ... size2 = e2 ... }
>> >> +(
>> >> +  __copy_from_user(exp2,(T2)&src,size2)@p2
>> >> +|
>> >> +  __copy_from_user(exp2,&src,size2)@p2
>> >> +|
>> >> +  copy_from_user(exp2,(T2)&src,size2)@p2
>> >> +|
>> >> +  copy_from_user(exp2,&src,size2)@p2
>> >> +)
>> >> +  ...
>> >> +  }
>> >> +
>> >> + at script:python depends on report@
>> >> +p61 << rule6.p1;
>> >> +p62 << rule6.p2;
>> >> +s6 << rule6.src;
>> >> +e6 << rule6.f1;
>> >> +@@
>> >> +if p61 and p62:
>> >> +  post_match_process(6, p61, p62, s6, e6)
>> >> --
>> >> 2.7.4
>> >>
>> >>
>> >> --
>> >> Kees Cook
>> >> Nexus Security
>> >>
>>
>>



-- 
Vaishali
http://vaishalithakkar.in/
