From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 16 Oct 2015 23:18:21 +0200 (CEST)
Subject: [Cocci] extremely slow processing of trivial header file
In-Reply-To: <87a8rio7f7.fsf@rasmusvillemoes.dk>
References: <87a8rio7f7.fsf@rasmusvillemoes.dk>
Message-ID: <alpine.DEB.2.02.1510162311390.2056@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, 16 Oct 2015, Rasmus Villemoes wrote:

> Hi
> 
> I just ran into a slightly weird case. spatch takes forever handling a
> simple header file which contains nothing but #defines.
> 
> I tried
> 
>   https://github.com/Villemoes/linux-cocci/blob/master/microopt/copy_bit.cocci
> 
> on
> 
>   drivers/gpu/drm/amd/include/asic_reg/gmc/gmc_8_1_sh_mask.h

I think that your semantic patch is suffering from over-isomorphism-itis.  
The semantic patch becomes very complicated, and the .h file is very big 
(over 15 000 lines, and probably about the same number of top level 
entries, none of which match).

I would suggest at least to get rid of the following one:

TestExpression
@ not_int2 @
int X;
@@
 X => X != 0

With this change, the performance should be acceptable.  I have attached 
the updated semantic patch.

julia


> 
> With --profile, the first few lines are
> 
> $ spatch --include-headers --no-includes --patch . --profile -I arch/x86/include -I arch/x86/include/generated -I include -I arch/x86/include/uapi -I arch/x86/include/generated/uapi -I include/uapi -I include/generated/uapi -I include/linux/kconfig.h -D patch --cocci-file /home/villemoes/projects/linux-cocci/microopt/copy_bit.cocci ./drivers/gpu/drm/amd/include/asic_reg/gmc/gmc_8_1_sh_mask.h
> init_defs_builtins: /usr/local/lib/coccinelle/standard.h
> HANDLING: ./drivers/gpu/drm/amd/include/asic_reg/gmc/gmc_8_1_sh_mask.h
> Note: processing took    41.8s: ./drivers/gpu/drm/amd/include/asic_reg/gmc/gmc_8_1_sh_mask.h
> starting: Common.group_assoc_bykey_eff
> ending: Common.group_assoc_bykey_eff, 0.000004s
> ---------------------
> profiling result
> ---------------------
> Main total                               :     42.428 sec          1 count
> Main.outfiles computation                :     41.845 sec          1 count
> full_engine                              :     41.845 sec          1 count
> bigloop                                  :     39.998 sec          1 count
> process_a_ctl_a_env_a_toplevel           :     39.933 sec      93930 count
> mysat                                    :     39.782 sec      93930 count
> rule3a                                   :     39.451 sec          1 count
> 
> Other headers in drivers/gpu/drm/amd/include/ also take a long time. Any
> ideas? I'm using 'spatch version 1.0.2 with Python support and with PCRE
> support'.
> 
> Rasmus
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
> 
-------------- next part --------------
/// Code such as
///
///   if (foo & FLAG)
///       bar |= FLAG;
/// 
/// can, in most cases, be replaced by
///
///   bar |= foo & FLAG;
//
// One case where it's not ok is of course when FLAG doesn't consist
// of a single bit. But that's not why gcc doesn't perform this
// transformation: The problem is that it is invalid if bar is not
// writable; one could imagine a situation where bar is only writable
// in the case where foo does contain FLAG.
//
// However, nobody writes code that way, so it should be pretty safe
// to just do the transformation in the source (but do check the
// 'single bit' condition before blindly applying patches generated
// by this). If a series of replacements is done, as in
//
//   if (foo & F1)
//     bar |= F1;
//   if (foo & F2)
//     bar |= F2;
//
// then gcc is smart enough to actually transform
//
//   bar |= foo & F1;
//   bar |= foo & F2;
//
// into
//
//   bar |= (foo & (F1 | F2));
//
// Confidence: Medium
// Options: --include-headers --no-includes
//

virtual patch

@rule1a depends on patch disable not_int2@
expression src, dst;
constant c;
@@
  if (unlikely(src & c)) {
    dst |= c;
  }

@script:python rule1b@
c << rule1a.c;
@@
try:
  x = int(c, 0)
  if ((x & (x-1)) != 0):
    cocci.include_match(False)
except:
  pass

@rule1c depends on patch disable not_int2@
expression rule1a.src, rule1a.dst;
constant rule1a.c;
@@
- if (unlikely(src & c)) {
-   dst |= c;
- }
+ dst |= src & c;

@rule2a depends on patch disable not_int2@
expression src, dst;
constant c;
@@
- if (unlikely((src & (1 << c)) != 0)) {
-   dst |= 1 << c;
- }
+ dst |= src & (1 << c);

@rule2b depends on patch disable not_int2@
expression src, dst;
constant c;
@@
- if (unlikely((src & BIT(c)) != 0)) {
-   dst |= BIT(c);
- }
+ dst |= src & BIT(c);

@rule2c depends on patch disable not_int2@
expression src, dst;
constant c;
@@
- if (unlikely((src & BIT_ULL(c)) != 0)) {
-   dst |= BIT_ULL(c);
- }
+ dst |= src & BIT_ULL(c);

// A rare variant is where we want to clear a bit in dst if it is
// clear in src. This is somewhat uglier to do with pure bitops, but
// it's doable. We don't bother testing whether c is a literal
// non-power-of-2, since that would be extraordinarily odd. When
// manually checking the generated patches, remember to also take
// types (and signedness) into account; something which is easy to
// screw up with bitops transformations.
@rule3a depends on patch disable not_int2@
expression src, dst;
constant c;
@@
- if (unlikely(!(src & c))) {
-   dst &= ~c;
- }
+ dst &= src | ~c;
