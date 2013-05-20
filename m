From: lars@metafoo.de (Lars-Peter Clausen)
Date: Mon, 20 May 2013 20:26:04 +0200
Subject: [Cocci] isomorphism with unlikely
In-Reply-To: <20130520182415.GA6975@katana>
References: <20130520173406.GB5890@katana> <519A61A8.7010402@metafoo.de>
 <20130520182415.GA6975@katana>
Message-ID: <519A6ABC.1090004@metafoo.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 05/20/2013 08:24 PM, Wolfram Sang wrote:
> 
>> There is already an isomorphism for unlikely. But it is in one direction
>> only, so 'unlikely(E)' in your cocci script will also match 'E', but 'E'
>> wont match 'unlikely(E)'.
> 
> Okay, but I would then still need 'unlikely(!r)' and 'unlikely(r ==
> NULL)' because the !r isomorphisms won't apply. I'd like to have both :)

No, just unlikley(r == NULL) also matches !r (and unlikely(!r)). This should
also work for unlikely(!r) matching unlikely(r == NULL) but for some reason
it doesn't. I just did a quick test and it looks as if even 'if(!r) ..."
doesn't match 'if(r == NULL) ...' either.

- Lars
