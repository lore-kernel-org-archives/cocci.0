From: eliseomarmol@gmail.com (=?utf-8?Q?Eliseo_Mart=C3=ADnez?=)
Date: Wed, 21 Jan 2015 11:51:56 +0100
Subject: [Cocci] Possible to install on OSX?
In-Reply-To: <20150121095749.GB4529@pl-59055.rocqadm.inria.fr>
References: <DA6D9998-6B28-4982-BC25-04787C96111B@gmail.com>
 <20150120083300.GA8575@pl-59055.rocqadm.inria.fr>
 <20150120110023.GA25368@pl-59055.rocqadm.inria.fr>
 <5B67F95E-64BD-4C91-88FA-B632B69CBF94@gmail.com>
 <20150120132253.GA27243@pl-59055.rocqadm.inria.fr>
 <85CD4387-710E-4369-BBA4-028126F58B02@gmail.com>
 <20150120134112.GA27573@pl-59055.rocqadm.inria.fr>
 <8435030F-881E-451C-A931-1E2E6EB08AD4@gmail.com>
 <20150120144214.GA28186@pl-59055.rocqadm.inria.fr>
 <9ADF75C3-1736-4D66-AF22-107FE12F73CD@gmail.com>
 <20150121095749.GB4529@pl-59055.rocqadm.inria.fr>
Message-ID: <11AEB35C-0894-462E-8264-FD62F2336103@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi S?bastien, 

> Did we reach a state where your coccinelle works as expected under OS X?

I still have to be able to compile with python support. But coccinelle itself is working great.
I?ll try to follow your previous indications on that to solve it myself.
I will get back to you after some time If I am not able to do it. ;-)

Thanks very much for your patience, kindness and supportiveness.

Regards, 
Eliseo.

Thanks very much for your patience and su
> On 21 Jan 2015, at 10:57, S?bastien Hinderer <Sebastien.Hinderer@inria.fr> wrote:
> 
> Hi Eliseo,
> 
>> Working patch attached.
> 
> thanks!
> 
>> Real problem was repetition symbol ?+?. For BRE?s on OSX, you need
>> ?\{1,\}? instead (weird, I know ;-)
> 
> Indeed, but very well spotted, thanks.
> 
>> Apart from that, I improved in a couple of ways:
>> - Use single quotes instead of double quotes, to avoid shell
>> - interpolation interference.
> 
> Good idea, thanks.
> 
>> - Add ?_? to accepted character class.
> 
> I didn't take that bit because it seems unlikely to me that one will want
> to use _ at such a place.
> 
> Also, Coccinelle's build system may change a bit during this year so
> hopefully this piece o coe will vanish completely.
> 
> Many thanks for your patience, reactivity and support in all this.
> 
> Did we reach a state where your coccinelle works as expected under OS X?
> 
> Cheers,
> S?bastien.
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
