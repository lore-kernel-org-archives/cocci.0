From: nicolas.palix@imag.fr (Nicolas Palix)
Date: Wed, 3 Jul 2013 15:52:31 +0200
Subject: [Cocci] [PATCH 3/3] Coccinelle: Update the options used to the
 new option scheme
In-Reply-To: <51D428F4.6020003@suse.cz>
References: <1371726656-24928-1-git-send-email-nicolas.palix@imag.fr>
 <1371726656-24928-2-git-send-email-nicolas.palix@imag.fr>
 <51D428F4.6020003@suse.cz>
Message-ID: <CAAxaTiMgaCp17um0NnF2gbWDoRZnb2GOq-50LRAvV_dDdEsjRg@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

On Wed, Jul 3, 2013 at 3:36 PM, Michal Marek <mmarek@suse.cz> wrote:
> On 20.6.2013 13:10, Nicolas Palix wrote:
>> spatch has changed its option scheme.
>> E.g., --no_show_diff is now --no-show-diff
>>
>> This patch updates:
>>  - scripts/coccicheck
>>  - Semantic patches under scripts/coccinelle/
>
> Will the new syntax work with older spatch versions?
> I mean, it's
> probably fair to require a recent version, but it should be documented IMO.

It is the opposite. The new spatch still supports the old
naming scheme. The more conventional naming has been introduced
in spatch version 1.0.0-rc11 in March 2012. I will send a new patch to
document that point.

>
> Also, there was no patch 2/3 in this series, only 1/3 and 3/3.

It seems you finally found the v2 of this one. :)

Regards,

>
> Thanks,
> Michal
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci



--
Nicolas Palix
Tel: +33 4 76 51 46 27
http://membres-liglab.imag.fr/palix/
