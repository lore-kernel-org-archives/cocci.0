From: valentinrothberg@gmail.com (Valentin Rothberg)
Date: Mon, 25 May 2015 08:30:56 +0200
Subject: [Cocci] [PATCH] coccinelle: irqf_oneshot.cocci: Improve the
 generated commit log
In-Reply-To: <alpine.DEB.2.02.1505250820520.2045@localhost6.localdomain6>
References: <1432500354-10562-1-git-send-email-festevam@gmail.com>
 <alpine.DEB.2.02.1505250820520.2045@localhost6.localdomain6>
Message-ID: <CAD3Xx4KJcfknCCvBgO1zte2q+KLjJ1mfR82ixx=Ejwc1P8xmow@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, May 25, 2015 at 8:21 AM, Julia Lawall <julia.lawall@lip6.fr> wrote:
> Valentin?  (It's his semantic patch)
>
> julia
>
> On Sun, 24 May 2015, Fabio Estevam wrote:
>
>> From: Fabio Estevam <fabio.estevam@freescale.com>
>>
>> Improve the commit log of the generated patch by mentioning the commit
>> log that makes threaded IRQs without a primary handler to be requested
>> with the IRQF_ONESHOT flag.
>>
>> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
>> ---
>>  scripts/coccinelle/misc/irqf_oneshot.cocci | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/scripts/coccinelle/misc/irqf_oneshot.cocci b/scripts/coccinelle/misc/irqf_oneshot.cocci
>> index b17ac8b..b421150 100644
>> --- a/scripts/coccinelle/misc/irqf_oneshot.cocci
>> +++ b/scripts/coccinelle/misc/irqf_oneshot.cocci
>> @@ -1,5 +1,8 @@
>> -/// Make sure threaded IRQs without a primary handler are always requested with
>> -/// IRQF_ONESHOT
>> +/// Since commit 1c6c69525b40 ("genirq: Reject bogus threaded irq requests")
>> +/// threaded IRQs without a primary handler need to be requested with
>> +/// IRQF_ONESHOT, otherwise the request will fail.
>> +///
>> +/// So pass the IRQF_ONESHOT flag in this case.
>>  ///
>>  //
>>  // Confidence: Good
>> --
>> 1.9.1
>>
>>

Acked- by: Valentin Rothberg <valentinrothberg@gmail.com>

Kind regards,
 Valentin
