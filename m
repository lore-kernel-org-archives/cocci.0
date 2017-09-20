From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 20 Sep 2017 11:14:41 +0200 (CEST)
Subject: [Cocci] [PATCH v3 0/5] bq27xxx_battery data memory update
In-Reply-To: <CAKvHMgTF8C+7xcO31MvVeepCmSiP4V6tvvC4uVfcA4_JAfFHsw@mail.gmail.com>
References: <20170824033617.20840-1-liam@networkimprov.net>
 <0bf4ba2f-18f9-1204-8241-8acb6ac6f490@ti.com>
 <20170829212259.gs4bljwscrprsfjl@earth>
 <CAKvHMgTEe_xBP2ENMTU5BNwWaRjfqbAuRJC32sHYL_Mh5oJOsQ@mail.gmail.com>
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
Message-ID: <alpine.DEB.2.20.1709201108070.3290@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 19 Sep 2017, Liam Breck wrote:

> On Tue, Sep 19, 2017 at 3:00 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
> >
> >
> > On Tue, 19 Sep 2017, Liam Breck wrote:
> >
> >> Hi Julia,
> >>
> >> I think Sebastian referred this to you in hopes of receiving a script
> >> that would find duplicate arrays, similarly to the way
> >> bq27xxx_battery_dbg_dupes does in the running code. Did you interpret
> >> his request differently?
> >>
> >> bq27xxx_battery_dbg_dupes:
> >> https://patchwork.kernel.org/patch/9918953/
> >>
> >> The data structures being checked start here:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git/tree/drivers/power/supply/bq27xxx_battery.c?h=for-next#n138
> >>
> >> And are aggregated here:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git/tree/drivers/power/supply/bq27xxx_battery.c?h=for-next#n743
> >>
> >> The defines can be sed'd to pointers with 0 value, and array
> >> comparisons where 1 pointer is 0 can be skipped.
> >
> > I followed the spirit of the runtime testing code.  But Coccinelle doesn't
> > normally unfold the definitions of macros.  All it can do is take the
> > different lists of fields and see if they are textually the same.
>
> There's no need to unfold macros. If you did, you would get false
> positives. You do need to skip them somehow, hence the idea of sed'ing
> to null pointers.

I meant that for the properties, the values are:

static enum power_supply_property bq27000_props[] = {
	POWER_SUPPLY_PROP_STATUS,
	POWER_SUPPLY_PROP_PRESENT,
	POWER_SUPPLY_PROP_VOLTAGE_NOW,
	POWER_SUPPLY_PROP_CURRENT_NOW,
	POWER_SUPPLY_PROP_CAPACITY,
	POWER_SUPPLY_PROP_CAPACITY_LEVEL,
	POWER_SUPPLY_PROP_TEMP,
	POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW,
	POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG,
	POWER_SUPPLY_PROP_TIME_TO_FULL_NOW,
	POWER_SUPPLY_PROP_TECHNOLOGY,
	POWER_SUPPLY_PROP_CHARGE_FULL,
	POWER_SUPPLY_PROP_CHARGE_NOW,
	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
	POWER_SUPPLY_PROP_CYCLE_COUNT,
	POWER_SUPPLY_PROP_ENERGY_NOW,
	POWER_SUPPLY_PROP_POWER_AVG,
	POWER_SUPPLY_PROP_HEALTH,
	POWER_SUPPLY_PROP_MANUFACTURER,
};

Coccinelle is comparing the list of names, not the list of integers that
these names are expanding to.

Also, Coccinelle is comparing the list, but I guess you would prefer that
it compare the set, to check for the cases where the names are the same
but appear in a different order.


>
> > I've attached the script and some fake data that I made to test it.  The
> > fake data has some added cases where I have replaced 27 in the structure
> > name by 07.  For my test data I get:
> >
> > bq07421_regs and bq27421_regs have the same registers
> > bq07000_regs and bq27000_regs have the same registers
> > bq07421_dm_regs and bq27421_dm_regs have the same registers
> > bq07421_props and bq27421_props have the same properties
> > bq07000_props and bq27000_props have the same properties
> >
> > You won't get this currently; I needed to make some improvements to the
> > Coccinelle C code parser.
>
> I didn't see anything attached, script or data.

Sorry, should be there now.

> The script should compare each object with only those objects that
> follow it in sequence, so it doesn't repeat comparisons or compare to
> self.

It does this, ie it only compares xxx to yyy when xxx is alphabetically
less than yyy.

julia
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
i1props_vals << getprops1.i1props_vals;
i2props_vals << getprops2.i2props_vals;
i1props << tocheck.i1props;
i2props << tocheck.i2props;
@@

if i1props < i2props && i1props_vals = i2props_vals
then Printf.printf "%s and %s have the same properties\n" i1props i2props

-------------- next part --------------
A non-text attachment was scrubbed...
Name: battery.c
Type: text/x-csrc
Size: 57648 bytes
Desc: 
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20170920/768b48e0/attachment-0001.bin>
