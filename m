From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 27 Sep 2017 12:02:06 +0200 (CEST)
Subject: [Cocci] [PATCH v3 0/5] bq27xxx_battery data memory update
In-Reply-To: <CAKvHMgTUrdF_ZmJYOB3jn020BMv-70MLpUBosBLstDrBN_KY9w@mail.gmail.com>
References: <20170824033617.20840-1-liam@networkimprov.net>
 <20170830002939.ns43wldvffmwqhuv@earth>
 <CAKvHMgSyr8aZ1cVd-Zf6WHNkwyTcSBvRaVuDWuHEnuNM=MStUA@mail.gmail.com>
 <alpine.DEB.2.20.1708311150440.3243@hadrien>
 <CAKvHMgSkuzi_BuicT7edYrM8Q87pnPJcgHRMDJEB21wdNKf8ow@mail.gmail.com>
 <alpine.DEB.2.20.1708311330570.3243@hadrien>
 <CAKvHMgSKLJk2wB9pefYuGyMG2aNp7bCCaOMABGRxXZ9ju-ivHw@mail.gmail.com>
 <CAKvHMgRzFpueUccSL1iu_-EazCe76cF8iSAPyYgcxJ3dNOZejA@mail.gmail.com>
 <alpine.DEB.2.20.1709052214030.2058@hadrien>
 <CAKvHMgTE-vypWKjhR7QgQNHFbVNdg99MgARmC-cTv6vfjgzZFg@mail.gmail.com>
 <alpine.DEB.2.20.1709180731060.2547@hadrien>
 <CAKvHMgSnULnEAtW5Axi1fyJG_2YW7hD3K_-N5P3Xdq_Gn72z4A@mail.gmail.com>
 <alpine.DEB.2.20.1709192355160.2518@hadrien>
 <CAKvHMgTF8C+7xcO31MvVeepCmSiP4V6tvvC4uVfcA4_JAfFHsw@mail.gmail.com>
 <alpine.DEB.2.20.1709201108070.3290@hadrien>
 <CAKvHMgTUrdF_ZmJYOB3jn020BMv-70MLpUBosBLstDrBN_KY9w@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1709271154400.3186@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

The github version of Coccinelle finally supports the semantic patch for
your code.  I have attached the semantic patch.  I wonder what should be
done with this?  Do you want to use it locally with make coccicheck?  Do
you want it to be integrated into the kernel?  Everything in the semantic
patch depends on the occurrence of BQ27XXX_DATA, so if make coccicheck is
used on files that don't contain this word, they should be ignored very
efficiently.  So perhaps it is ok for scripts/coccinelle even if it is
relevant to only one file.

julia
-------------- next part --------------
A non-text attachment was scrubbed...
Name: battery.c
Type: text/x-csrc
Size: 57648 bytes
Desc: 
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20170927/c5f18b40/attachment-0001.bin>
-------------- next part --------------
@str@
type t;
identifier i,i1,i2;
expression e1,e2;
@@

t i[] = {
  ...,
  [e1] = BQ27XXX_DATA(i1,...),
  ...,
  [e2] = BQ27XXX_DATA(i2,...),
  ...,
};

@script:ocaml tocheck@
i1 << str.i1;
i2 << str.i2;
i1regs; i2regs;
i1dmregs; i2dmregs;
i1props; i2props;
@@

if not(i1 = i2)
then
  begin
    i1regs := make_ident (i1 ^ "_regs");
    i2regs := make_ident (i2 ^ "_regs");
    i1dmregs := make_ident (i1 ^ "_dm_regs");
    i2dmregs := make_ident (i2 ^ "_dm_regs");
    i1props := make_ident (i1 ^ "_props");
    i2props := make_ident (i2 ^ "_props")
  end

(* ---------------------------------------------------------------- *)

@getregs1@
typedef u8;
identifier tocheck.i1regs;
initializer list i1regs_vals;
@@

u8 i1regs[...] = { i1regs_vals, };

@getregs2@
identifier tocheck.i2regs;
initializer list i2regs_vals;
@@

u8 i2regs[...] = { i2regs_vals, };

@script:ocaml@
(_,i1regs_vals) << getregs1.i1regs_vals;
(_,i2regs_vals) << getregs2.i2regs_vals;
i1regs << tocheck.i1regs;
i2regs << tocheck.i2regs;
@@

if i1regs < i2regs &&
   List.sort compare i1regs_vals = List.sort compare i2regs_vals
then Printf.printf "%s and %s have the same registers\n" i1regs i2regs

(* ---------------------------------------------------------------- *)

@getdmregs1@
identifier tocheck.i1dmregs;
initializer list i1dmregs_vals;
@@

struct bq27xxx_dm_reg i1dmregs[] = { i1dmregs_vals, };

@getdmregs2@
identifier tocheck.i2dmregs;
initializer list i2dmregs_vals;
@@

struct bq27xxx_dm_reg i2dmregs[] = { i2dmregs_vals, };

@script:ocaml@
(_,i1dmregs_vals) << getdmregs1.i1dmregs_vals;
(_,i2dmregs_vals) << getdmregs2.i2dmregs_vals;
i1dmregs << tocheck.i1dmregs;
i2dmregs << tocheck.i2dmregs;
@@

if i1dmregs < i2dmregs &&
   List.sort compare i1dmregs_vals = List.sort compare i2dmregs_vals
then Printf.printf "%s and %s have the same registers\n" i1dmregs i2dmregs

(* ---------------------------------------------------------------- *)

@getprops1@
identifier tocheck.i1props;
initializer list[n1] i1props_vals;
@@

enum power_supply_property i1props[] = { i1props_vals, };

@getprops2@
identifier tocheck.i2props;
initializer list[n2] i2props_vals;
@@

enum power_supply_property i2props[] = { i2props_vals, };

@script:ocaml@
(_,i1props_vals) << getprops1.i1props_vals;
(_,i2props_vals) << getprops2.i2props_vals;
i1props << tocheck.i1props;
i2props << tocheck.i2props;
@@

if i1props < i2props &&
   List.sort compare i1props_vals = List.sort compare i2props_vals
then Printf.printf "%s and %s have the same properties\n" i1props i2props
