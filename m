Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F6A9C61DA4
	for <cocci@archiver.kernel.org>; Sat, 18 Mar 2023 07:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=2Ue8+379fDutTn7J9DBZcDWuZrxJPjTNlc7vuFSHT94=;
  b=gW8TxArKCzYqER71qmM5V+k+nL5iq73ZQLQOK9gjMdilnTL5T3XPSHj+
   vxEWsbQ64b8lS0uf5tJ5eNHQjKDTiIzeJgABUpIwS/gnv/9T9YRRtO5QS
   7MQ77f0VJL2Hp7raEh4sx9L/GcAXqCKxc02miHa55zE1bop4md2x4MgWM
   I=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="5.98,271,1673910000"; 
   d="scan'208";a="97859803"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Mar 2023 08:30:47 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2E158E0AEF; Sat, 18 Mar 2023 08:30:47 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id ABBC5E0A9B
	for <cocci@sympa.inria.fr>; Sat, 18 Mar 2023 08:30:45 +0100 (CET)
IronPort-SDR: 641568a4_tjlemifud/95yii2mcGWd5hjt9HFMKrSoYEyLLs09XIwoT3
 O1jRptnxGluG8AGsl7eXc9imdIQaFVmxj9VlKAw==
X-IPAS-Result: =?us-ascii?q?A0HIBwD3ZxVkhwQP49RQCoEJgU+CLnVWLwQLRoRTjwqBd?=
 =?us-ascii?q?y4DaYNGk02EAoMWPg8BAwENPQQBAgQBAQMEgguCcwKFNQIdBwEEMwYOAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBAQIQAQEBGgkXBw4FCwUihWgNg?=
 =?us-ascii?q?jcpARFkgQgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBARICDToYOz0BAgIBIx0BA?=
 =?us-ascii?q?REbCwEECwsaAiYCAlcGAQwGAgEBgnoBgicBAw4jBwy0WoEygQGCCAEBBoFAA?=
 =?us-ascii?q?ZpJHywiU4FeAwaBFC2NA4M2eicPgVVEgTyDAz6CSxcEGIEZLYNYgmeCKYdfg?=
 =?us-ascii?q?26LHwqBNHaBIA6BPYEEAgkCEWuBEghrgX1BAg1lCw52gUwCZU8nJQQOAxkrH?=
 =?us-ascii?q?UACAQs7Oj81BgMLIQZYawIJJBETBQMLFSpHBAg5Bhs0EQIIDxIPBiZDDkI3N?=
 =?us-ascii?q?BMGXAEpCw4RA0+BRwQvXIEBBgEmJJxBTAJSZyAmgRhCHZJIFAmDIwGPHJ4ON?=
 =?us-ascii?q?AeCKIFVgVkMigyVAAYTLoN9jGaGJQ4GkiMuhy2QDyCLQ4FvlQ2FO4F4JIFcM?=
 =?us-ascii?q?xokT4JnTwMZD445hAyEYYpmQDQCAQE3AgcBCgEBAwmFRgEBhXsBAQ?=
IronPort-PHdr: A9a23:PeHoyhErJhevsibYZeUT+J1Gf9RGhN3EVzX9CrIZgr5DOp6u447ld
 BSGo6k30RmTBt6QsqoUw8Pt8IneGkU4qa6bt34DdJEeHzQksu4x2zIaPcieFEfgJ+TrZSFpV
 O5LVVti4m3peRMNQJW2aFLduGC94iAPERvjKwV1Ov71GonPhMiryuy+4ZLebxtIiTanf79/I
 hu7oQrMusUKgoZpN7o8xAbOrnZUdOtawn9lK0iOlBjm/Mew+5Bj8yVUu/0/8sNLTLv3caclQ
 7FGFToqK2866tHluhnFVguP+2ATUn4KnRpSAgjK9w/1U5HsuSbnrOV92S2aPcrrTbAoXDmp8
 qlmRAP0hCoBKjU063/chNBug61HoRKhvx1/zJDSYIGJL/p1Y6fRccoHSWZdQspdUipMCZ6+Y
 YQSFeoMJeVWoYfyqFQAsBWwGxehBO3vxDBKmnD40rY30/g4EQzcwAAsA9wDvXbSod7oNKkSS
 +e1zKzQwDvEdfxWwzT96JXTchs8rv+MWbxwcdDQyUkpGAPOk1Kdp4v/MDOP1eQNrnOb4/BvW
 +KrhW4nsQBxoj6gxso3hIjGmJkaxkrZ+ipn2Ys4I8CzR0Fnb9C+CpRQqz2aOJVsQsMkW2xlt
 ig3xL0atJOnYCUG1IoqyhzfZfGbcYWF/hztWeKTLDp3gH9pZbayihW8/0WkyeDxV8253lhFo
 ydHktTBt3AD2hrO4caJTft9+12u2TeJ1w3L6eFLP1o0lazFJJ4l2LIwkYATsUvFEyTrm0v2l
 Lebels59uS28ejrfKvqq52GO4NpigzyKKsjltS7DOk3KAQDUXWX9f6/2bH+50H0Q7tHg/srm
 afDqp/aP94UpquhDg9VzIkj7xG/Ai+j0NQfgHkHMEhJeRyZgIfyIV3BPe73Ae++g1Sqjjhr2
 +jLMqP8DpnTNHTPjqntcLRn50JByAc/199S64pRCr4bIfLzXkHxtMbfDh88KwG6xPzoCM9+1
 oMDQmKDGKCXMKfcsV+S5+IvJeaMaZQbuTnjMPcp/ePhgmEhlV8bZqamxYEXZ2ygHvR6P0WZZ
 mLhjsoZHWcQogU+VPDqiEGFUTNLe3myWL4z6S06CI+9FofCRoWtgKSb0yuhH51WYHpGClGWH
 nvyeYWEQaREVCXHBMZ9kjUCHZywTYQhnUWovRP6wrxjBu7V/DAI85Pp0Z5+4OiF0Vk29DppH
 9yF2CSBQn9cmmITWyRw27J7qEZmjFCZ3uwwgPFCE9FXovFAVAYmMoTH5/J1Bsq0WQ/beNqND
 lG8TYaIGzY0G/c42dwTeA5QH9u4jxbMl36PCqUWiqfNKZg66KPa0FDuKsw7x3uQh/pptEUvX
 sYabT7uvaV47QWGQteRyy1x9o6vfKUYh2vW8XubiHGJpAdeWRJxVqPMWTYeYFHXpJL3/BCKV
 KegXJIgNAYJ0sueMu1ScNS8qFxcR+r4fvnabXiwnWiYGhuCgL+BP8LxY2tI5CzGEwAflhwLu
 3OPNAwwHCCk9kfXFj9zDhTCZ0328O9xgGy2RAk4wlLCdFVvgpyy/BNdnvmAU7UT07YD7T8ms
 ClxFU2h0sj+Dt2du0x+ca8abd5VDE5v82XfukQ9O5WhK/snnVsCa0FsuFuo0RxrC4JGmMxsr
 XUwzQM0J7jKmFVGPyiV25z9INi1YiH74QyvZqjK21rfzMfe+6EB7+49okniuwfhH1Qr8nFu2
 d1Ym3WG4ZCCAA0XWJP3GkE5knoy75TTeCog/MX50XN2MK+7miDP0ZQlCaptyxqtecteLLLRD
 BX7QIURA8mjLvBvmkD8NEteeroIq+htYoX6JJ7kkOaxMe1tnSyrlzFC6YF5iQeX8jZkD/XPx
 9ADyu2Z2Q2OU3H9ik2gu4b5g9MhB3laE2yhxCzjHIMUaLd1eNNBLG60INCsgPh6iYTsXXFw6
 1OpQV8LkpzMG1Lafxnm0Atc2F5C61mugyil1HpZlz8zr6yQ9DPDyaLueVBUXwwDDHknhlDqL
 4+uitkcV0X9dAklmiyu4kPizrRarqByR4XKaX9BZDO+b2RrU6/r86GHf9YK85Qw9yNeTOW7Z
 1meDL/7uRoTlS35TSNSwzUydjfivZuc/VQyrWuHL2to6lfdd9txwxj3+9HWA/JcljYLXyh3j
 zDLC0P0ZYDzu4/OyNGa76biH2u6HoVeayzq0Z+NuE7ZrSVxDBuzkury0tzrHA4m0DPqgtxjV
 CHGthH5McHg06W3N/4if1E9XgamrZAgRccnz81s1/RykTAAi56Y/GQKizL2ONRfguflaWYVA
 CUM25jT6RTk30tqKjSIwZj4XzOT2JgEBZHyb2UI1yY6980PBr2T6ekOuCJvoUej6y/Vb+J8m
 Dg11vYkrnIXybJs2kJl3mCGD7YeEFMNdwnljReV9JaTqKtNZWCgWae93gxykJryadPK6hEZU
 3H/dJA4GCZ25cgqK1PA3kr47YT8ccXRZ9Ye5VWE1g3NhO9PJNcth+IH0GB5bHnlsyRvmItZx
 VR+mIu3t4+dJyBx8bKlV1RGYybtaZpb+ymx3/wHxIDMhd/pR88/XGxRDNyyEJfKWHoTrai1b
 V/UVmdm9THCRPyHWlXCoEZ+8yCVSsrtbSvIYiBGi40lHkbVJVQD0lpNA3NlxNhgR1rsnpCxN
 x0og1JZrl/g9kkckKQxaUS5CzqO4l/vMGl8SYDDfkAPsUcdvQGPaZPYtqUpQGlZ5sHz9lXSb
 DPBIV0ZVydXBgveWTWBdvGv/YWSo7LeX7TjaaGUMPPX8rQWVu/Ul8L1lNI4onDWbZ3JZCMqS
 vQ/3gArsWlRPcPfln1PTiUWk3mIdMuHvFKn/TUxqMmj8fPtUQap5I2VCrIUP889sxaxybyOM
 eKdnkMbYX5Ry48MyHnUybMewE9aiidgcCOoGKgBsiiFRbzZm6teBRoWIy1pM84A46U51whLc
 cnV77G9nqZ/leIwAkxZWEbJn8a0eYoVLmv7OF6GTEeHObKaJCHalsH6ZaTvLN8YxO5QthC2p
 XOaCxq5Z27FzWO2EUnyd70f6UPTdAZTs4y8bBt3XG3qTda9Lwa+LMcyljouh7s9mnLNM2cYd
 zl6aUJE6LOKvkY6yr1yHXJM6n19IKyKgSGcuqP9I4wVrOAtLyB6jeNc71wlxrET4CwOF5kX0
 GPC68VjpV2riLzF0j18TB9HsSpGnqqOulh+f7rU/N9MVDyXmXBFpXXVABMMqdx/D9TpsK0F0
 dnDmpX4LzJa+s7V988RbyAxAN2KOjwtPEixcNY7JBQIR3inODOG76S8uPSV62HTsZUw7JThy
 sJmdw==
IronPort-Data: A9a23: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
 RzyOpE9A/Rp/qxUeA==
IronPort-HdrOrdr: A9a23:aAqzd6p/UY7os3EazcCls7gaV5r/eYIsimQD101hICG9vPbo9f
 xG785rsSMc7wxhIE3I+OrwQZVoJEm2yXcb2+Ys1NuZLW7bUS6TXedfBOjZrQEIeReTygc178
 4JHpSWSueAaGSS5vyb3ODXKadC/PC60OSPmfrUyWtrQDpncqd68m5Ce3um+wFNJTWvHvACZe
 GhDyd81kCdkf97VK6GOkU=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,271,1673910000"; 
   d="scan'208";a="50553284"
X-MGA-submission: =?us-ascii?q?MDFDOaKHXDGy8EjN/Zph5dgIDhts3Yn8p9KeMh?=
 =?us-ascii?q?W5EAenRpRcqPCxuaC1OGj0KeyanDMoZdAygWvhXDXSKckxTCLRbyvRdQ?=
 =?us-ascii?q?XOmAL7xNLJgV80hgvtytsnGmcsl6vMJKIv+q31gOjRmsvG8wTaIYCUle?=
 =?us-ascii?q?rQO6dFLkMmVHh7V6uTyUl67Q=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2023 08:30:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679124636; i=markus.elfring@web.de;
	bh=2Ue8+379fDutTn7J9DBZcDWuZrxJPjTNlc7vuFSHT94=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=rJmpHn1n+JaqQ6ItrNWhym/N3q4laM5suDOq4T5nM3TJdZ7a76gdobV6/ntV5fBhL
	 JJ/PBEusXKhEBrsHOWDNuhAdAA87nDBuNTbnrFeJaPlyWRpDWhR0xkfybkJzQMum2U
	 rMIySJaGep+p9JytBelVO0RCHIivkqxKFGYOjnEA/wEu2xspwxyavXRxwpW2OBR2X6
	 KSdnzu+c3/w+bB8U6JEPSc1Ae7OU9h+s5pi0RS+AqSWsm+cZlLNuDE0Bf2TTroQ+zw
	 kYfGCoJtG78GsV+RIxFz0zTOIUQCrf7Bqq7dPGSnbkt5NM9B+rcIudWBFGsbigw+1J
	 51r4B351snNFw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mo6O7-1qJcbH03NT-00pP2H; Sat, 18
 Mar 2023 08:30:36 +0100
Message-ID: <2f5a00f6-f3fb-9f00-676a-acdcbef90c6c@web.de>
Date: Sat, 18 Mar 2023 08:30:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
To: Nathan Lynch <nathanl@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 kernel-janitors@vger.kernel.org
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Paul Moore <paul@paul-moore.com>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <0981dc33-95d0-4a1b-51d9-168907da99e6@web.de> <871qln8quw.fsf@linux.ibm.com>
 <a01643fd-1e4a-1183-2fa6-000465bc81f3@web.de> <87v8iz75ck.fsf@linux.ibm.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <87v8iz75ck.fsf@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nrXu9o1RWEyss7JnYRxXUWlz+FjOMFGmKla96LHwpfwW9GKcvXZ
 A66tiAfPrCo5unXHT7cLWnXXEg3rq6xA+uFPRcKX6d1eR4ryzMZy+frzUWsDhg59khKwLXW
 akE5oUdQV9bML+SSJFs8T0p3hpFB4dL//QEf/oHDmJnzWoOozMcOOgGtwKhfWu3T2643GZi
 odNQEbvTA8O+8nONcr7Gg==
UI-OutboundReport: notjunk:1;M01:P0:0ktdu+qVn9g=;ird6o2d6PfBr7fHOh/fpfXNIoW7
 qbn4oHrU2xXh0Me011KPFt72uFFFRRaOsugL5EbfSzIf3EYufD1wUzSAyqn4HqRuWcy2fVey1
 e2vov9sgfQGWhvnxXJpLs59j7HCpoGszhatn8RcqPM9pOlckHndt+pfDPnMZ+5BRGU8uGvSmr
 X47R8qL+2mU5vAGCiBYGOfh7EyCvckBwYBPkdf8kvoayKhln9WOqEwpGhWqThdIOUoMRMG4eQ
 KSoMlj0vftYmQj2WVII3/d0M7JGng9ulOtAj8qA/H+yEdU4Mx1UMMBOA3pkjf/E1/I0Y6jf7j
 D6nxHPp+zWbLirBOO66/9iKpih26D/RrDEd2aaM4FqLqILRpOHO6i4XSvuTB014yOExuG8+wB
 6ujWSXfziw8dLlgc8mbCAlqqryhWx0hAFssoNb9etBhkCRQSayqj002aSdrl8qoXicCec1mKO
 YaxHQnviUvgVj2wT93p3+vdbEjcs3v1aUfOOXDGBoS6HZLMyDvHtsW+Huem/Cos5zWFBzuhCz
 W/Rg2JJ4jkhHfNrTqZ37FTrFOklw4UCDw+oV82VKbjLemQuASeM03a9JaSkH+MgkPGR4H6f3/
 P3JaCH8DJayD8cM+ixC5nzoq2DfPXy7TkP8loXm2g2KbSGjaMfzZoNIfmDJ356oP5FH6itmMn
 dQlRWqn9SGA2z6npR4wFTXCcRtxx2wERjLiSEpqomhTsprhoEMux6X+s7bE3dNE9e3/4rxt6q
 dfSnHgeOZh1JGkoiPD8zD1Xv0Els7jqjdaMb9pCGzhXQY53g0qOMNeDEZtj2kUZuOLBi7JWc5
 i/jnLOwlT7NJrLOzUIJ6aPMyiLGgakjRz6E95cUKAlLZjgymrk2LcvIOqXpb6ZqHBOq4+ggG2
 /fty9LEruSEppMqVI8oaIyqCKNUs3P3sZKz2m2dLIhEVunLQEvHFvjlEB8TaSRAB/Jc5WAzM/
 Bms8gA==
Subject: Re: [cocci] powerpc/pseries: Fix exception handling in
 pSeries_reconfig_add_node()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 894
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
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/2f5a00f6-f3fb-9f00-676a-acdcbef90c6c%40web.de>

>>>> The label =E2=80=9Cout_err=E2=80=9D was used to jump to another point=
er check despite of
>>>> the detail in the implementation of the function =E2=80=9CpSeries_rec=
onfig_add_node=E2=80=9D
>>>> that it was determined already that the corresponding variable contai=
ned
>>>> a null pointer (because of a failed function call in two cases).
>>>>
>>>> 1. Thus return directly after a call of the function =E2=80=9Ckzalloc=
=E2=80=9D failed.
>>>>
>>>> 2. Use more appropriate labels instead.
>>>>
>>>> 3. Delete a redundant check.
>>>>
>>>> 4. Omit an explicit initialisation for the local variable =E2=80=9Cer=
r=E2=80=9D.
>>>>
>>>> This issue was detected by using the Coccinelle software.
>>> Is there a correctness or safety issue here?
>> I got the impression that the application of only a single label like =
=E2=80=9Cout_err=E2=80=9D
>> resulted in improvable implementation details.
> I don't understand what you're trying to say here.

What does hinder you to understand the presented change description better
at the moment?


> It doesn't seem to answer my question.


I hope that my answer will trigger further helpful considerations.


>>> The subject uses the word "fix" but the commit message doesn't seem to=
 identify one.
>> Can you find the proposed adjustments reasonable?
> In the absence of a bug fix or an improvement in readability, not really=
, sorry.

The views are varying for =E2=80=9Cprogramming bugs=E2=80=9D, aren't they?


> It adds to the function more goto labels and another return,

This is the suggested source code transformation.


> apparently to avoid checks

Can the support grow for such a programming goal?



> that are sometimes redundant

Can such implementation details become undesirable?


> (but not incorrect) at the C source code level.

Will this aspect affect further development concerns?



>> Please take another look at available information sources.
>> https://lore.kernel.org/cocci/f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.=
de/
> I wasn't cc'd on this and I'm not subscribed to any lists in the recipie=
nts
> for that message, so not sure how I would take "another" look. :-)

I imagine that you can benefit more from information which can be retrieve=
d
by archive interfaces also according to the mailing list of the Coccinelle=
 software.

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/dev-tools/coccinelle.rst?h=3Dv6.3-rc2#n9

Regards,
Markus
