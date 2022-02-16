Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35517C433EF
	for <cocci@archiver.kernel.org>; Wed, 16 Feb 2022 13:34:21 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.88,373,1635199200"; 
   d="scan'208";a="21667361"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Feb 2022 14:34:20 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EA6CBE0163; Wed, 16 Feb 2022 14:34:19 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 06DBBE008D
	for <cocci@sympa.inria.fr>; Wed, 16 Feb 2022 14:34:18 +0100 (CET)
Authentication-Results: mail3-smtp-sop.national.inria.fr; spf=None smtp.pra=Markus.Elfring@web.de; spf=Pass smtp.mailfrom=Markus.Elfring@web.de; spf=None smtp.helo=postmaster@mout.web.de
IronPort-SDR: NrQ+MIxZ3/qq0uZA7QQcQXcWWHdy3SUhymw+PtejmaVUOJI2BuOXvsABhWXCJ71uG2K0BTX+L6
 5zAWJbsOMNLN9YIqmK4Ilbv1wE9yQO38jqwLA1TCFaX1fDLXVWXpQotAvGmPxplAr3eGdI9Yxk
 rr0kxGCoHtyG4QeINm8/fS24aCynDsnT+ELY8/y5oTHrhSl8rTMP93vrCGxgDAH6274KEK97Sg
 UMG63AM9VNBNAGhPoywVQGlFoioDZPBQba0ho28WuGYOGusHjMHdd+YrIaynC4iqX2dmPa57Vk
 wm7AA5nKuJ2p4JPrsBFDr98c
X-IPAS-Result: =?us-ascii?q?A0DSGQBY/Axihw4P49RagQmBXIImaWwrBAtChFSIKIhKf?=
 =?us-ascii?q?YpOhxOKJIF7CwEDAQ0SASsBAgQBAYISgmyEDQIdBwEEOAINAQIEAQEBAQMCA?=
 =?us-ascii?q?wEBAQEBAQMBAQUBAQECAQECAwQBEwEBAQwNCQUICgcOBQsFNgZeBmQEgUsEg?=
 =?us-ascii?q?XQLNA2CNQwYhBMdAQERJxQgAiYCgQOCc4JlAQMyq3aBMYEBgggBAQaESB8sI?=
 =?us-ascii?q?lKBWwmBEC2GEAsIQoJOhTYQgVVEgUgBgkaGAIJLgmWYOZISrTw0B4IQgToFg?=
 =?us-ascii?q?ToLiB6WCjMDg0wBklsGkU4dli2hOoU4gg+BZzMaJIM4TgECAQINAQICAwECA?=
 =?us-ascii?q?QIJAQECjjaEC4osQDQ4AgYLAQEDCYVHAQGLVQEB?=
IronPort-PHdr: A9a23:PdcFJhOX7M9abCO+LcQl6nZ4BxdPi9zP1u491JMrhvp0f7i5+Ny6Z
 QqDv68r0wGCAN2TwskHotKei7rnV20E7MTJm1E5W7sIaSU4j94LlRcrGs+PBB6zBvfraysnA
 JYKDwc9rDm0PkdPBcnxeUDZrGGs4j4OABX/Mhd+KvjoFoLIgMm7yf6+94fRbghJizawYa9+J
 wiqoAvMscUbnZFsIbsrxBvTpXtIdeVWxWd2Kl+Wgh3x+MS+8oN9/ipJo/4u+NJOXqv8f6QjU
 LxXFy8mPHwv5M3qrhbMUw2C7WYBX2oMkxpIBw/F7AzmXpr0ryD3uPZx1DWcMMbrSr86RTSs4
 rlyRBPxlSoILSM2/nzJhcx2l6JboQ6hpx1hw47VfIGUNOd1cqfDcd8GQGZMWNtaWS5cDYOmd
 4YAAOkPM+ZGoYfgu1QAoxixCxO3CePz1jNFnGP60bEm3+kjFwzNwQwuH8gJsHTRtNj7M70dU
 fq2zKnV1jXIcvxY2TPz6IjScxAhp/6MVq93fMTW00YvDQDFjkiLqYD/MD2V0uoNs3Ka7+pmW
 uKikGAmpB9qrTS128gjlJDEi4QIwV/L6St32pw6JcGkSEFle96kFoNdujyHO4doQc4vQm5lt
 Ds+x7EYvZO2YSYHxZsoyhDQa/KLbpaF7w/jWuqPIzp1mHxrday+ihu98Uat1/PxW8i63VtMs
 yFLkcHMu2gT2xDO9MSLUOVx8lmj1DqVygze6vtILV07mKbDNZIt36A8moAOvUnMESL6glv6g
 a+Iekk+5OSl6+rqb7P7rZGGLYB0kBvxMqE2l8y/H+s4Ng8OUnCe+eS7yb3j4Vf1QbtUgfIti
 KXWrY7VKdwapq6/HQBVzp4u5wiiAzu4ytgUg2cLIVBfdB6aj4XlIUzCLf/gAfe6mVuskTNrx
 /7cPr3mB5XANn/Nn637fbZ+9k5c0xA/w99b55JaELEBIfTzWkDqud3WEBA2KBa4zPv5B9ll0
 IMRQnqAArWFP6PKrV+I+uUvLvGRaIMNojbyN+Al5+LyjX8+gVISYa6p0ocLZ3C5BflmOEWYY
 X/0gtgbC2sKvww+TPbriFKYSzJTaWyyDOoA4WQwD4mtDK/CQJqsifqPxnSVBJpTM0VPEFORC
 j/Fc4ueWvEDIHa3K9VijydCeLyvUY4n2jmxuQW8x7cxfbmcwTERqZ+2jIs93ObUjxxnr2Qc5
 6W11miMSzoxhWYUX3ot27g5p0Vhy1CF2Kw+gvpCFNUV6ekaGhwiO8v6yOp3Q8v3RhqHZs2AH
 XOvWNa7GnccStwrwtkBS1lwEZOug0OLxDKkVoccjKfDH5ko6uTZ1nn1Kdx6ziPj3bMikkJgb
 89BL2ygiYZg+gKVC4Oa216BmfOMcqIRlDXI6H/FzWeKuxRAVxVsVKzeQX0FTk7RsMi/+U7IC
 bOjYVg+Gi1Gz8PKaq5Da9myyE5DWO+mI9PGJWS4h2a3Ax+MgLKKdovjPWsHjm3bDwAfngYf8
 GzjV0B2Dzq9o2/YED1lFE7+K0Lq/+5krXqnT0gyhwiUZkxl3rCx91Ybn/uZA/8U27sFvm8mp
 VAWVB6Y1sjVFsHGig5vZqRabvsi7V0B2W+Y/w1xM5q8Lrxz00YEelc/tEfv2hNrT4RYxJJz9
 jVwllU0cP/eiQ8SElHQlYr9MbDWNGToqRWmaqqNn0rbzM7T4aAXrvIxt1TkugitUEsk6XRul
 ddPgB7+rt3HChQfVZXpXwM57R9/8vv/azM++piS+HliK6iyvRfd1thvCOZvmXPCN59PdbiJE
 gP/CZhQIsG0K/Ex3XWtYAgFOu9666M+ec+rPajjuubjLKNrmzSoin5C6YZ23xeX9iZyfeXP2
 o4M3/CS2gbvuy7UtF66qYi3nIlFYWpXBW+j0W3/A5YXYKRufIENAGPoIsutx9w4iYS/E3Jf8
 VeiARsB1qrLMVK3Zkb+wBYW+EAZu32hlgOnwjYynzxhoqeE3SPIyvjvb1JdYzQNHjM9yw6xZ
 9Hox9kBFFCldQ0oiAeo6SOYj+BAqaJzInOSCUZEci7qLn1zB665t76MeclKu9sjtSRaVvj5Y
 EjPEOen5UFAjGW6Qi0HmGNeFXnioJjykh1khXjIKX9yqCGcYsRs3VLE48SaQ/dN3z0ATS0+i
 D/NB1H6McP6mLfc35rFrO26UHqsE5NJdiy+h6aJriim/itHBROlnva8ssLqG0423GWosrsiH
 TWNtxv6boTxgu6fOPhkY1IuKVvy8ct8Falhn4F2iJxaih14zt2FuHEAl2n0K9BS36nzOWEMS
 TA8yNnQ+AH52UdnIyHB18fjW36a2Mcke8iibzZcxHcm984TQvTxjvQMjW5vr1G/tw6UffVtg
 mJX16418HBDy+AR5Fh3l3/bWOpNWxACY2q1zUTPtY3bzu0fZX7zI+Lpjgwkx4/nVezE+kYGB
 T74YstwR3YqqJ8lbxSVjzurrdu7MNjIMYBJ70LSzE2G1rkPbshtxr1Q1E8FcSr8pSF3m7R91
 EIzm8jn7c7fbD8ztKOhXkwCb2KzOJlVoGmyy/4ZxJne3pjzTM84RXNUBt2xHKjuTm5V76qCV
 U7GESVg+CfBX+OBQEnFshYg9imXW5GzayPHfj9Ak4gkHkLFYhYFyEUdWDFw9nIgPiatwsGpM
 EJw5zRKo0X9tgMJ0eVwcR/2TmbYog6sLDYyUpmWahRMvElE4A/OPMqS4/gWfWkQ94C9rAGLN
 m2QZhhZRWAPVEueAln/P76ordDe+umcD+C6IrPAe7KL4eBZUv6Jw9qo3O4Et36UMd6TO3B5E
 /Ah8k9EQGw/BMnT3TkCCmQWmy/Lc8+HtUK89ylw/aXduLzgXAPi45fKCqMHa4w1vUrs3uHaa
 qjJ2HUcS34QzJ4HyH7WxaJK2VcTj3orbDyxCfEbsjaLSqvMm6hRBhpdaiVpNcIO4bhvu2sFc
 cPdlN7x0aZ1y/AvDFIQH3nogMK0foonJ2+nNVXILFmGPvKKKHeYpqO/KbP5UrBWgOhO4leov
 i2HFkb4IjmZvzzuSgzpLuxGyi2Wdk872sn1YlNmDm7tS8jjYxuwPYpsjDE49rYzg2vDKW8WN
 TUUm6xlsbCaqy9V0KwX841p6314Ma+blizf4+SKcv7+VNN0Dy4ym+8IuBwH
IronPort-Data: A9a23:WhQec6zw8roPtmeDFYV6t+cwwCrEfRIJ4+MujC+fZmUNrF6WrkUAz
 mQeXmuOOKqJYzaked5/PNy+8U8PuJXXn9YwGwRuq1hgHilAwSbnLYTAfx2oZ0t+DeWaERk5t
 51GAjXkBJppJpMJjk71atANlVEliefQAOOU5NfsYkidfyc9IMsaoU8ly75RbrJA24DjWVvX4
 I2q+qUzBXf8s9JKGjJMg068gEg31BjCkGtwUosWOJinFHeH/5UkJMp3yZOZdxMUcaEIdgKOf
 Nsv+Znilo/vE7jBPfv++lrzWhVirrc/pmFigFIOM0SpqkAqSiDfTs/XOdJEAXq7hQllkPg2l
 MsKlr6+TDwjO4zAyP0iQSkIPBlXaPguFL/veRBTsOSWyFDaNWThybNiASnaP6VCo7wxWzsRs
 6VFbmlRBvyAr7reLLaTb+B2hdk4auTvMpkevH5I0jzTS/orKXzGa/uStIIGjWpYasZmP/DYY
 MwfQmNVfB3EYSVvGWkqKcgAg7L97pX4W2QF9AzM/PRfD3Lo5Ad227PsGMHEf8SDA8RThEeR4
 Gzcl1kVGTkfM8GDjyWI+DSgi4cjgB8XRqpVSKP/1dxkhWaZw00fWAQpR2vrjsGQ3xvWt81kF
 2QY/S8nrK4X/UOtT8XgUxDQnENoriLwSPINS7Fhsl3lJr78vFbAVjJsoitpNYR+3PLaUwDGw
 XelsrsF7xRKt7uJQHiU6638QdiaZHZJdDdqicMsdwsI4t/nqYc/yyrBR9JxeJNZY/XwHizsh
 S+Hpm4yit3/bPLnNY3roTgrYBr1+PAlqzLZAC2JBQpJCSsnPuaYi3SAswSz0Bq5BN/xoqO9l
 HYFgdOCy+sFEIuAkieAKM1UQu31tqrUYGWE2g8xd3XEy9hL0y77FWy3yG4vTHqFzu5fJFcFn
 WeO5VIKu8E70IWCN/UvON/Z5zsWIVjITIm5CKmNMLKik7AoOlbP/SdyaFSW0nylmUdErE3ME
 cfzTCpYNl5DUf4P5GPuGY81iOZ3rghjmz+7bc2lnnyPjOvGDFbIGOxtGAbfPogRsvnZyC2Lq
 Iw3H5XRlH1ivBjWOXS/HXg7dgxRchDWxPne96RqSwJ0ClA2SDt6WqCLmO5Jlk4Mt/09q9okN
 0qVAidwoGcTT1WeQelTQnw8Or7pQ7hlqnc3YX4lMVqyhSo8bIzp4KpGL8k7erwu9epCy/9oT
 qBZKpvaXakVEmzKq2YHcJ3wjI1+bxD11wiACCqSZmRtdZBXQQGUqMTveRHi9XVVAyfu7Zk+r
 rSs2xn1W50GQwg+Xs/aZOjxnUy8tz4RlbsqDUfPJ9BSfmTq8ZRrcnCg0KVofptUcRian2mUz
 QebBxsctNLhmY5t/Ymbn72AoqeoD/B6QBhQEV7b2rDqZyPUyWyunN1bW+GScDGBD2759fnwZ
 ehRyP2gYvQLkEwT6th5FKt3i70z7Z3jquYCnAhjGXzKaXWtC69heyXXg5MQ6/cVnrIJ6xGrX
 k+v+8VBPevbMs3SEGkXeFgvYNOF2KxGgTLV9/k0fB736XMl5raBSkkObRCAhDYEdelwN545h
 /gssoga5lXn2BYtN9+HiAFS9niNdyBRDf9468tCWIK72BA2zlxiYIDHDnGk6p+4a+JKbhsgL
 AiSifeQnL9b3EfDLyE+GHWlMTCxXnjSVM2mDWPuJmhlXvLAgeIrmgJc+3I7Q2y5C/mBP/1bY
 gBW249dfM1iPAuEQOBcUmrqFwwp6Nix5Bnq01VQ/IHGZxDAa4EORVHR/c6S8Upf/280kv23O
 l2H4D6NbAsGt/0dEsf/tYCJZhAjoRFMGtX+pf2a
IronPort-HdrOrdr: A9a23:Vc/n9Kx6oY0aHUDVLi5yKrPwH71zdoMgy1knxilNoH1uA6+lfq
 WV98jzuiWE6gr5NEtPpTmgAtjkfZq+z/JICOsqUotKNTOO0AaVxEQI1/qH/9SKIU3DH4BmtJ
 uICJIOb+EZFjJB/KDHCeSDYq8dKODsytHRuQ9Uok0GcT1X
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.88,373,1635199200"; 
   d="scan'208";a="6095695"
X-MGA-submission: =?us-ascii?q?MDHJlh056nz7wBhkAAHNQpABJjECTXsZBIpIGP?=
 =?us-ascii?q?+sGOIy6zRtb11j+1HMqEYuT///ESS2B9cKtJzh1CrEQs67gAyMqd/zHn?=
 =?us-ascii?q?9RSdoyNf5ube39JHh9CjmF1fzuIUxdNVU7rUv3bHXpKegB2HW3tT/yaP?=
 =?us-ascii?q?dBiEr326sAunxSw4k5RwEZWg=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 14:34:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1645018456;
	bh=4zzN4TIfs296t6DWwENxvSHw3wzkfSMy3Vrv0GfZN5g=;
	h=X-UI-Sender-Class:From:To:Subject:Date;
	b=dbPlwRnDP5Z0k23NaOlgpw8DRnEWp7c6nXdQsla5mxTG9yCq5ad9kGZS31dtUMD8x
	 JJg176gpLVEM1KQbAI2BHiy1oeeUxyg+Tt0OUj2gZ441r02g2CzpGmw7hVOCIRG54F
	 NjzbsKIxrF9+eNa0vjEybETuPCxktdt1hyPLrJWg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [212.144.252.253] ([212.144.252.253]) by web-mail.web.de
 (3c-app-webde-bs60.server.lan [172.19.170.207]) (via HTTP); Wed, 16 Feb
 2022 14:34:16 +0100
MIME-Version: 1.0
Message-ID: <trinity-d2f86e7d-49b0-44e7-8673-ffac34794a80-1645018456602@3c-app-webde-bs60>
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Feb 2022 14:34:16 +0100
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:uvJlulfc+PnpbuTVEns4N95czAEw/gKeAlZ51Z1QP3j+VdAwe+Ho9B1ozq5nUdLB6VeTs
 4XNjcEXyvElenU0V0ZFyLwV9VAXB6MilL7lpaxCH98eQtEUV+aynkothmHesVHb6JifLbOqomXFb
 Npp10iazuszJr1D3n7YwGDBmUJaN8CIqk9JuOgqenw4cNQQYxH/GYCa87Vsw9bXmjEZFNytRPlSX
 XL9lFsGMr5hL4Qz4li16I5ZolNIoO+g7cESW11hOr0KX+Lgyxfw74iRPq0ATIeeybix7X8fhsK93
 A0=
X-UI-Out-Filterresults: notjunk:1;V03:K0:EP/z6EUx7SQ=:tVjLfmcBILOBKSfc3qdV80
 3WJLjlpvVN1rkkb06+8Er1pzO88iuKm9bK6jda7SCsEzWw2aR7A2+bJpWUkPEA8ZZDX++vzKE
 7Jb7cisiHQbpoFqUb08SlanUDnCv5QRSYWIRnHqq0LDEQb1pwrmy5EIQg+uoPN8NIHmn0nhsd
 HhipzyceUvAJbHYxy+3qqE0nHamuuENLKjEeFYU6wMXrRIdrgnG+6rIEzSohD2QK9ZeOdNVSh
 ac1Wc+PaDNr/20A1GiLU+yBxFH19JLMXpevf56p1Qyq3Vqu0q0UEWSMNURYVAo6qGmS5nhvtK
 4oiKHCFem7wUYZOsjB+AtU6SEs/UhOijUNZbQl0dp4zQQ6M1WXWH9AQAL4mK7ueeaJ5WJEFjv
 fRyTDbJ0r4CnE0FP4+9t3KJl7zTa7PmdjAqYixLQRzRbyeb3W+IwSJ7jQLPh9y+U8vE10Wx7n
 l3+fImxqcySTLiFaO5NSTfskopScRGCUMh5TX9Xw6/cS5fzSkMRHaxvVSSPWSxx7ZHyHBAp51
 SwjSe5kqF50fKql3s9uYqtoNUKxjy9qLNJyrQT6dAJ3+TxMOadTDqw9i7Pu18yhem26QogEJC
 L/oRjr50uSODVw7t4FjfI6YzODHSiuG82JMbbaV2cUhCi7aXO8wXWnGun4ojZZ/J0vh1ptYPv
 N44pbfd0mZ7JsQG0H3LjFN/zBsrkdxsXBzrGYJ8Ddrnio0NLeqv/OeXN5yHJIMuxszyE8c/qb
 kSj8QOEP0+pt9CdK2hp5iiNe5aTKpRhfnCzb6GtaQmztJppb8zND2dAcI6v4hqm/dW6aOhzbf
 EhEWZ7t
Subject: [cocci] Supporting adjustments for JSON data structures with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 141
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-02/trinity-d2f86e7d-49b0-44e7-8673-ffac34794a80-1645018456602%403c-app-webde-bs60>

Hello,

Will chances grow to work with a semantic patch language variant for the handling
of JavaScript object notation data by the means of the Coccinelle software?

Regards,
Markus
