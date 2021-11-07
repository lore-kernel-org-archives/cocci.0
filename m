Return-Path: <SRS0=h9ga=P2=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158AFC433F5
	for <cocci@archiver.kernel.org>; Sun,  7 Nov 2021 12:10:25 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C80F613B1
	for <cocci@archiver.kernel.org>; Sun,  7 Nov 2021 12:10:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2C80F613B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
X-IronPort-AV: E=Sophos;i="5.87,216,1631570400"; 
   d="scan'208";a="2372035"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Nov 2021 13:10:22 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1926FE006A; Sun,  7 Nov 2021 13:10:22 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 9D91EE004C
	for <cocci@sympa.inria.fr>; Sun,  7 Nov 2021 13:10:16 +0100 (CET)
Authentication-Results: mail2-smtp-roc.national.inria.fr; spf=None smtp.pra=Markus.Elfring@web.de; spf=Pass smtp.mailfrom=Markus.Elfring@web.de; spf=None smtp.helo=postmaster@mout.web.de
IronPort-PHdr: =?us-ascii?q?A9a23=3AOeSejh9Es608Qf9uWZS8ngc9DxPPW53KNwIYoqA?=
 =?us-ascii?q?ql6hJOvz6uci4ZQqHtL401AaBHd2Cra4e06yO6+GocFdDyK7JiGoFfp1IWk1No?=
 =?us-ascii?q?uQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBAj0OxZ?=
 =?us-ascii?q?rKeTpAI7SiNm82/yv95HJbAhEmiexbaluIBiyogndq9UajZZ/Iao11hfFv2FEd?=
 =?us-ascii?q?utIyW90P16fgwrw6sKt95N/7ipcvO4s+dRdWqvgZaQ4SrJYDDUiM28r4cDgqAf?=
 =?us-ascii?q?OQwiS6HYCS2saihVHDRTL4xH8RZfxrzD1tvFh1ymAPM35Vq47VDK/5Kp2UhDoi?=
 =?us-ascii?q?SMHNzkk8GHLj8F7kaxWrA69qxF53oXZe5+eOuZgcazBfNMaXWtBUdhXVyxdGYO?=
 =?us-ascii?q?3co8DA/McMepEs4Xxol0Dpga8CwaxHuPi0jxGiHH50qI0zuovDw/G0gwiEN0Sv?=
 =?us-ascii?q?3rZt8n1NL4IXOyp0KXFwzfOYvVL0jn98ojIdRUhrOmLU71qa8rRylQvFxjYhVu?=
 =?us-ascii?q?frYzlMSmV1uULs2iU8uFtUuWhhHQ9qwFyvziv3d0ghIbNhoIb0FDE9CN5wIkuK?=
 =?us-ascii?q?Ny2VkF0esSoH4ZOuCyDMYZ9X8wtTX1ytikg1r0GpYC0fDIMyJk/2xPSauKKfoq?=
 =?us-ascii?q?J7x79SuufITN1iXZhdb+imxu/71asx+n8WMS10FhHrC5In9jQun4NyxHe68aKR?=
 =?us-ascii?q?/pj80q91ziC1Abe4fxKL0AzkKrUMZ8hwrgom5oQr0vDBCn2l1vyjKOMcUUk4Oe?=
 =?us-ascii?q?o5uL6abvlvp+RL5F4hhzgPqg0hMCzH+Y1PhITU2Wb4+ix2qXv8En3TblQk/E7n?=
 =?us-ascii?q?KnUvIrbKMkVvKK1HgBY34kl5h2iFTmpys4YkmMCLF9deBKIkYzpO1bWLfD9Cve?=
 =?us-ascii?q?/nkisnC1lxv/YJbLtGIjCIWbbnLfge7Zy9VJcxRItwdxC+Z5YEK8NLOzxV0Prq?=
 =?us-ascii?q?dDVDgU1PgKsz+biEtp914ceWWyVAq+eNaPfqViG6fg1I+mPeY8VoyzxJfch5/7?=
 =?us-ascii?q?gl385mFkdfaay0JoZdn+3Be5qLFiHbnb0mNcODX8KvhYiTOztkFCNTTlTaGquU?=
 =?us-ascii?q?KI9/Tw7E4KnDYLbRo+3mrCB3SG7HodXZm9cEFyMH23oJM24XKIybCuJPs5kkzh?=
 =?us-ascii?q?Mf7GrSIZpgQ+kvQX5wpJ8M/HZvCYK48HNzt9wssjajxIv7nRZC8qH0meCBzVRl?=
 =?us-ascii?q?3kLWiRw8aRxu017xX+c3KI+j/EORo8b3O9ATgpvbc2U9Od9Ed2nH1uZJr9hqX6?=
 =?us-ascii?q?jRci6Ry48RJQ9zo1WC66SM8qvhFbP0njza1fwv6OGDto4//CEt0U=3D?=
IronPort-Data: =?us-ascii?q?A9a23=3A2uCLaq20IsqAdKEO/fbD5Wtzkn2cJEfYwER7XOP?=
 =?us-ascii?q?LsXnJ1W4n1GAAn2UYWjzUa/nYYWv8fIwgao+08EwH7MfQm9MSHQtv/xmBbVoa8?=
 =?us-ascii?q?JufXYzxwmTYZn7JcJWbFCqL1yivAzX5BJhcokT0+1H9bdANkVEmjfvRH+OkV7a?=
 =?us-ascii?q?dUsxMbVYMpBkJ2UoLd9ER2dYAbeiRW2thiPuqyyHtEAfNNw1cbgr435m+RCZH5?=
 =?us-ascii?q?5wejt+3UmsWPpintHeG/5Uc4Ql2yauZdxMUSaEMdgK2qnqq8V23wo/Z109F5tK?=
 =?us-ascii?q?Nl7HmbgsVT7SUMQXmZnh+AfH4xEIY+Wprj+BgXBYfQR8/ZzGhutlry8hW87G0R?=
 =?us-ascii?q?x0oOKLkh+kXFRVVe817Ffcdp+WfeiLXXcu7lhCaLSK1nZ2CFnoeNooT8edfGnB?=
 =?us-ascii?q?L7fVeKTYXbxnFifje/V4RYv00059lcd2yadtZ4mU6mGmfV6t4H4SYFv2MuMsHi?=
 =?us-ascii?q?R4uoutLO9reQ+sQTwFqYCjaRSNOH0NOUMdm2L687pXkWzhftU7Tuqc9pWTepDG?=
 =?us-ascii?q?dGYPFaLL9EuFmj+0M9qpZmo7Hw4g9KhQdKcDZ1jePtH6h7gMKtUsXR6pKfIBUN?=
 =?us-ascii?q?NYz6LFQ+oDXIAIbXx23rJFVT2agDslHJRV8FjUG9MAPGY/CcjU5dwK1qjiIs3b?=
 =?us-ascii?q?wnvI4//ISsGmw90Yf3+pV6qXogNKMhBzKefLanQAX62I=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AYvsC4a4ss9QWWn2tkAPXwNrXdLJyesId70hD?=
 =?us-ascii?q?6qkXc3xom62j9vxG88516faZslsssRIb8+xoWpPwI080nKQdieIs1N+ZLWrbUQ?=
 =?us-ascii?q?CTQr2Kg7GP/9WqcxeOk9Jg6Q=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0CxAAB5wYdhhwMP49RaGwEBAQEBAQEBB?=
 =?us-ascii?q?QEBARIBAQEDAwEBAUCBWYMhVzoxhEeOb4F3MWmRMYwSCwEDAQ0wDgECBAEBgg2?=
 =?us-ascii?q?CdQKCUwIdBwEENBMBAgQVAQEFAQEBAgEDAwQBEwEBAQwNDggnEySFaA2CNSkBg?=
 =?us-ascii?q?2QBAgIBIxUIAQERJgEECwsODAImAgJXBg0IAQEXglYBglQBAw4lC6sCgTGBAYI?=
 =?us-ascii?q?IAQEGhEcfLCJRgVoDBoEQKgGOKCcQgVVEgTyDAz6CTBcEGIFGgxiCZY8rgSsQe?=
 =?us-ascii?q?8AGMweCC4EwgTkLiQqUGwYULZVkDgaRMJYQjHSUJoUSgXiBfTMaJIM4URkPjiA?=
 =?us-ascii?q?ZhAyEYYVLQDMCCS0CBgEKAQEDCYVHAQGLLAEB?=
X-IPAS-Result: =?us-ascii?q?A0CxAAB5wYdhhwMP49RaGwEBAQEBAQEBBQEBARIBAQEDAwE?=
 =?us-ascii?q?BAUCBWYMhVzoxhEeOb4F3MWmRMYwSCwEDAQ0wDgECBAEBgg2CdQKCUwIdBwEEN?=
 =?us-ascii?q?BMBAgQVAQEFAQEBAgEDAwQBEwEBAQwNDggnEySFaA2CNSkBg2QBAgIBIxUIAQE?=
 =?us-ascii?q?RJgEECwsODAImAgJXBg0IAQEXglYBglQBAw4lC6sCgTGBAYIIAQEGhEcfLCJRg?=
 =?us-ascii?q?VoDBoEQKgGOKCcQgVVEgTyDAz6CTBcEGIFGgxiCZY8rgSsQe8AGMweCC4EwgTk?=
 =?us-ascii?q?LiQqUGwYULZVkDgaRMJYQjHSUJoUSgXiBfTMaJIM4URkPjiAZhAyEYYVLQDMCC?=
 =?us-ascii?q?S0CBgEKAQEDCYVHAQGLLAEB?=
X-IronPort-AV: E=Sophos;i="5.87,216,1631570400"; 
   d="scan'208";a="2372032"
X-MGA-submission: =?us-ascii?q?MDHq5xWAIswkHKzXX5si6OdXpvz1mFuc+uw8AP?=
 =?us-ascii?q?H3zafWLPgzKdW7QJagFTXr4qMRHeYTLHZO2ghtHmU901MEr5hK7pd2Rr?=
 =?us-ascii?q?bjsoeGZNBgBk/weZmDSFCmVwqaRQk5olGrasGNa15euL7ikQhkrDV/M0?=
 =?us-ascii?q?sLYwsQhQ62iywrQ35ad0msnQ=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2021 13:10:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1636287014;
	bh=MV8NHIgO4mGgQmJcYRnI5YpdWSWO8R9iDOTIExk9Jxw=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
	b=ljhT34UJOLjnIyYkCKD0wnFHYNhrdbrvlk351QyAaUOkNmi/YZb4axrKobCd4+2Og
	 Md62faKppXH3czag9zND0RS6fsDophXA3w0WgzEIslxboS6ugvaqjv32qxjSDfCiRC
	 X4/6X0My9NE3+6312P11EaKR+/CvxPUt0S/8/8Ks=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.63.144]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MCXVX-1mrhTR1uHj-009Y8Q; Sun, 07
 Nov 2021 13:10:14 +0100
Message-ID: <a02a8c42-011d-0f9c-6a2f-7d45a3f216a5@web.de>
Date: Sun, 7 Nov 2021 13:10:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-GB
To: Vlastimil Babka <vbabka@suse.cz>
References: <17a7a40f-b736-e0ea-02ae-1b03ef4483bf@suse.cz>
Cc: cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <17a7a40f-b736-e0ea-02ae-1b03ef4483bf@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9qz/4WEw2oz7ySGtbBACUBofnYatNkVyWUb3YufH0oV6Dat0pcL
 pj/YRyinikOyBGdB5+GZlbLYbWqywAEdyjvfK4txeYA2x9L7sTLqaEneL6C/y6VhtXJFNo4
 Cs1wpsES/sJzt0Bpryt1gJjMFY1t2IJFOZRVRWsjOxk90g633VA4dDSmRZAzow94woPjdov
 FuZCeizlt9pdscKC018og==
X-UI-Out-Filterresults: notjunk:1;V03:K0:M7/ZEMJQ6OA=:Mv/+HrmPpq2tuNaouihJF6
 szj/aXua0+rrTW0wRYkqWCXy/7ytQpz7UhCTvZWuyufF21LWRKQsngKu9cBYeIldMh62aucot
 NTe58NeD3RA6EjNm/HydPVDDk0aHHsISunz4EJSlXymPehrXe52pjculUcXc8QjtGlQjBrhtv
 xrwx5QA35UyeMscXCkwxdn0332/vPydZwZ/sYpatUnaw2+90mJ497S2UNT85AU4jhh7xXNUtb
 mMf9wF//8CgWlf6WEtY00w4M0jRX7JpIA5ll7kta9z9FZHxp9/NsklYRmJIXANbgOl5Vqs+0h
 QPbZXwe9+U7nWSMLFAdrSPxaNBDXkdLfXoJiEOJCUuolWLk9OiMKzXqgrSShm1/WaFRI5eYY2
 xlNxP/XekTqeC34njeCBqE+9JQLe8hWP9D0q5CXeCIml4ZhGbCfPCT+E1iRVdUZhJhBqZDFxg
 s8ZGDxNG4v3zzYoz9AAWp2cpj9o7U37H9qh71GZV89JdwV7ddna1+bB3uthmt5RaLC/94cann
 pnSfOy9PGkBnQynI71ePrRfexIbPQe7dVPRkTBxmzeptSITAq0NHi8nO439tly+eCO19Deumg
 5LhSfvk0tAh39ElJwzF8qNqfQ0Z9QVX0VsGsG87L1B5JSuC44BoH6UhC1buC+w2eV7M4IY5C0
 FlWFTxU9CPFoblUvXiHA/DsZtQftJvi/CBawpRp5RDWJe5Q3/Bl1G6r/6dij7mDYeHqEluPvj
 HAMaRXU0aq1VphwNphM83G86ZvHNeBA7u6hj8X0nG4cPEYzOXRba2ygIzaAEDesY3dJ15+36U
 SjDDfB0yFc5cAt8uUL8/LHuA7ip1EnpLLASwhFgjEAh/F+21kZRASQ3pLwQvPuAYFJEJzRFwp
 WUaSfOEqslbxECgWvbhpf5uJE/heGZ4WdIF3lkkIVZOocief+euD76aKWh1uVdgAMHPWgmFST
 qx9xJ+783uwv5gZ4xXtteV7CWPbFdvjVYiKiBYNeiV8TU1PP1L7sH4UoZJFZ2j/WsRM62Ls+l
 Foog5CH02mxnJwSzxkMURhobtl/DJRA2lCFeaNsRrlO/cP3bUT70aiJMwa0AQ6oqwkY+vFapV
 XD33FP8246TZng=
Subject: Re: [cocci] mm/slab: prepare for struct patch conversion by spatch
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 87
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-11/a02a8c42-011d-0f9c-6a2f-7d45a3f216a5%40web.de>

> Because a lot of the changes there are mechanistic, I thought it would b=
e a
> good idea to perform them via coccinelle semantic patch. But it's my fir=
st
> attempt at large real usage of spatch, and it probably shows.

I guess that your clarification request will trigger further collateral ev=
olution.
Thus I suggest to reconsider also another commit message from your softwar=
e
development branch accordingly.
https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/commit/?h=
=3Dslab-struct_slab-v1r8&id=3D8a685ebb3b2a10c1d781d5b3e6ad0315ce9323d6

=E2=80=9CThis patch splits several declarations of multiple variables, or =
declarations
that include initial assignments, to separate lines, due to my inability t=
o
make a coccinelle semantic patch match on those declarations.=E2=80=9D

* How do you think about to specify desirable change preparations by the m=
eans of
   the semantic patch language?

* Will any guidance help to find nicer solutions?

Regards,
Markus
