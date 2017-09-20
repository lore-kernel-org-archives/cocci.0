From: liam@networkimprov.net (Liam Breck)
Date: Wed, 20 Sep 2017 02:41:46 -0700
Subject: [Cocci] [PATCH v3 0/5] bq27xxx_battery data memory update
In-Reply-To: <alpine.DEB.2.20.1709201108070.3290@hadrien>
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
 <alpine.DEB.2.20.1709201108070.3290@hadrien>
Message-ID: <CAKvHMgTUrdF_ZmJYOB3jn020BMv-70MLpUBosBLstDrBN_KY9w@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, Sep 20, 2017 at 2:14 AM, Julia Lawall <julia.lawall@lip6.fr> wrote:
>
>
> On Tue, 19 Sep 2017, Liam Breck wrote:
>
>> On Tue, Sep 19, 2017 at 3:00 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
>> >
>> >
>> > On Tue, 19 Sep 2017, Liam Breck wrote:
>> >
>> >> Hi Julia,
>> >>
>> >> I think Sebastian referred this to you in hopes of receiving a script
>> >> that would find duplicate arrays, similarly to the way
>> >> bq27xxx_battery_dbg_dupes does in the running code. Did you interpret
>> >> his request differently?
>> >>
>> >> bq27xxx_battery_dbg_dupes:
>> >> https://patchwork.kernel.org/patch/9918953/
>> >>
>> >> The data structures being checked start here:
>> >> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git/tree/drivers/power/supply/bq27xxx_battery.c?h=for-next#n138
>> >>
>> >> And are aggregated here:
>> >> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git/tree/drivers/power/supply/bq27xxx_battery.c?h=for-next#n743
>> >>
>> >> The defines can be sed'd to pointers with 0 value, and array
>> >> comparisons where 1 pointer is 0 can be skipped.
>> >
>> > I followed the spirit of the runtime testing code.  But Coccinelle doesn't
>> > normally unfold the definitions of macros.  All it can do is take the
>> > different lists of fields and see if they are textually the same.
>>
>> There's no need to unfold macros. If you did, you would get false
>> positives. You do need to skip them somehow, hence the idea of sed'ing
>> to null pointers.
>
> I meant that for the properties, the values are:
>
> static enum power_supply_property bq27000_props[] = {
>         POWER_SUPPLY_PROP_STATUS,
>         POWER_SUPPLY_PROP_PRESENT,
>         POWER_SUPPLY_PROP_VOLTAGE_NOW,
>         POWER_SUPPLY_PROP_CURRENT_NOW,
>         POWER_SUPPLY_PROP_CAPACITY,
>         POWER_SUPPLY_PROP_CAPACITY_LEVEL,
>         POWER_SUPPLY_PROP_TEMP,
>         POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW,
>         POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG,
>         POWER_SUPPLY_PROP_TIME_TO_FULL_NOW,
>         POWER_SUPPLY_PROP_TECHNOLOGY,
>         POWER_SUPPLY_PROP_CHARGE_FULL,
>         POWER_SUPPLY_PROP_CHARGE_NOW,
>         POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
>         POWER_SUPPLY_PROP_CYCLE_COUNT,
>         POWER_SUPPLY_PROP_ENERGY_NOW,
>         POWER_SUPPLY_PROP_POWER_AVG,
>         POWER_SUPPLY_PROP_HEALTH,
>         POWER_SUPPLY_PROP_MANUFACTURER,
> };
>
> Coccinelle is comparing the list of names, not the list of integers that
> these names are expanding to.

That's perfect.

> Also, Coccinelle is comparing the list, but I guess you would prefer that
> it compare the set, to check for the cases where the names are the same
> but appear in a different order.

Yes, ideally it would sort arrays before doing compare. Is that doable?

>>
>> > I've attached the script and some fake data that I made to test it.  The
>> > fake data has some added cases where I have replaced 27 in the structure
>> > name by 07.  For my test data I get:
>> >
>> > bq07421_regs and bq27421_regs have the same registers
>> > bq07000_regs and bq27000_regs have the same registers
>> > bq07421_dm_regs and bq27421_dm_regs have the same registers
>> > bq07421_props and bq27421_props have the same properties
>> > bq07000_props and bq27000_props have the same properties

We can just write
"%s & %s are identical"

>> > You won't get this currently; I needed to make some improvements to the
>> > Coccinelle C code parser.
>>
>> I didn't see anything attached, script or data.
>
> Sorry, should be there now.
>
>> The script should compare each object with only those objects that
>> follow it in sequence, so it doesn't repeat comparisons or compare to
>> self.
>
> It does this, ie it only compares xxx to yyy when xxx is alphabetically
> less than yyy.

Ah, I had misread your results log.

Looks promising! :-)
