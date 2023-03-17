Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7FE3C6FD1D
	for <cocci@archiver.kernel.org>; Fri, 17 Mar 2023 14:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=SCwrapoV90k7PPQXDoRWVOZ47w9dirURaRogquQ3emo=;
  b=McAVwl0l9qRiUksBiIPlpNU8d0jQyZc1nXfJvB7taHmvIdp6Fg0eI8fl
   OIFie/RnhvzCLNv0N4FRiUMzakMFxinelaf7crOgK3HTs6M5LBPBuwp/h
   2HVZJORZLoUUzop6cgiSSOttpccjuLoen1aVlxLLQd8gxVjmk5dxiJkjb
   M=;
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
X-IronPort-AV: E=Sophos;i="5.98,268,1673910000"; 
   d="scan'208";a="97783866"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Mar 2023 15:20:24 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 37AE4E00DA; Fri, 17 Mar 2023 15:20:24 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 7C4A7E0010
	for <cocci@sympa.inria.fr>; Fri, 17 Mar 2023 15:20:22 +0100 (CET)
IronPort-SDR: 64147725_RVl4ZrE/ZCnYpD37ETK8lL0MAGjOupy0N/sipRvNGs/qB5d
 FT7gnfbp/QNzdVeNig4uhwlwOMyXdzTqQtG3zZA==
X-IPAS-Result: =?us-ascii?q?A0EmBQCKdRRkhw4P49RQCh4BAQsSDECBRAuCLnVWLwQLR?=
 =?us-ascii?q?oRTkQEuA4Quk0yEAoFWgUA+DwEDAQ07BgECBAEBAwMBgguCcwKFNQIdBwEEM?=
 =?us-ascii?q?gcOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBAQIQAQEBGgkXBw4QB?=
 =?us-ascii?q?SKFaA2CNykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAg06GDs9AQICASMdAQERJgEECwsaAiYCAlcGAQwGAgEBgnoBg?=
 =?us-ascii?q?icBAw4jBwwGsx+BMoEBgggBAQaBQAEDAgwCQ5lzHywiU4FeAwaBFCyNBIM2e?=
 =?us-ascii?q?icPgVVEgTwMgnc+gmIDgTItg1iCZ4Iph1+DYIsaCoE0doEgDoE9gQQCCQIRa?=
 =?us-ascii?q?4ESCGuBfUECDWULDnaBTAJlTyYlBA4DGSsdQAIBCzs6PzUGAwshBlhrAgkkE?=
 =?us-ascii?q?RMFAwsVKkcECDkGGzQRAggPEg8GJkMOQjc0EwZcASkLDhEDT4FHBC9cgQEGA?=
 =?us-ascii?q?SYknQtSZQIgJoFaknkJgyMBjxyeDjQHgiiBVYFZDIoMlQAGEy6DfYxmhiUOB?=
 =?us-ascii?q?pIjLoctkA8gi0OBb5pIgWkBMoFcMxokgzZPAxkPjiAZhAyBC4NWimZANAI5A?=
 =?us-ascii?q?gcBCgEBAwmFRgEBhXsBAQ?=
IronPort-PHdr: A9a23:SQPe9h0KxAkEo8MpsmDOYg4yDhhOgF0UFjAc5pdvsb9SaKPrp82kY
 BaCo6821hSXBc3y0LFttan/i+jYQ2sO4JKM4jgpUadncFs7s/gQhBEqG8WfCEf2f7bAZi0+G
 9leBhc+pynoeUdaF9zjaFLMv3a88SAdGgnlNQpyO+/5BpPeg9642uys+5DfeRtEiTSjbb99L
 Ri6sRjau9ULj4dlNqs+xRzFr2dSde9L321oP1WTnxj95se04pFu9jlbtuwi+cBdT6j0Zrw0Q
 rNEAjsoNWA1/9DrugLYTQST/HscU34ZnQRODgPY8Rz1RJbxsi/9tupgxCmXOND9QL4oVTi+6
 apgVQTlgzkbOTEn7G7Xi9RwjKNFrxKnuxx/2JPfbIWMOPZjYq/RYdYWSGxcVchTSiNBGJuxY
 YgBAeUOM+lWspfzqkUArRW+BwajGOzhxyRUhn/vx6A2z/gtHA/E0QEmAtkAsG7UrNLwNKoKV
 u661rPIzTbeb/NNxDzz54zIch47ofGNW7JwftfaxE4oGQzflFWQqpHlPyiP2uoCt2ib4fBgV
 eOpi24osAxwrCagydw2hobUmI0Y01bJ/jh2z4gpP9O3UlJ7YcK6H5tKsSGXL4h7T8AsTmxpu
 Ss3yaELtIK4cSUJzJkr2RDSZ+Kbf4WG/x/uV+ecLSl4inxrd7+zmxa8/Vagx+DiSsW60FZHo
 yVDn9LRuH4N0BnT5dKGSvt75kqh2iiA1xrV6u5aJUA4j63bK4QuwrIol5oTt17DHi7sl0nsg
 q+WbEMp8fWr5eT/erjquIKQO5Fuhg3gLKgjmNazDfk4PwQUQmSW9vyw2bns8EHjTrhGk+c6n
 6rEvJzAJskWqKi0CBJP3Ik58RawFTKm3cwYnXYZKFJFfwqKj43uO1HTPPD0F/m+jEq3nztx2
 v/JIKXtApTLLnfdjLfsZahx51NCxAYp09xT+ZBZBqscLP/zQEP9qdPVAgc8MwOuwubnDNt91
 pkZWWKKGqKXN7ndsUWL5uIyOOmAfoAbuDLzK/g/5v7ui3A5lEQTfKa3xpQbcm23Eep+L0Wfe
 nXjms0BHnsSvgoiUOzqj0WPXSNLa3aoQ608/i07CJ6hDYrbWo+th6CO0zu6HpBNfWBHClWME
 W/yeImeWvcMbjiSIs57nTAeW7ihUdxp6Rb7kgbmy7NhZs7F/CYY/cbl3cR17uvXvRUz8yFkS
 cWX1ieGSGQi2isMRjkrzLhnqglxx0mr1aljn+ceEs5X7vlSFAAgOtqUzOFgDd32HwDIeNaVT
 0y9asupDCt3Td8rxdIKJUFnFIaMlBfGig+jGbwIjPSmAJIu86TTlyzULtx+1m2A+a0vlVggT
 eNQOGfgiqMppFubPJLAj0jMz/XiTq8bxiOYsT7blQJm3WldWQ90C+DeWGwHI1HRppL/71/DS
 LmnDfImNBFAwIiMMPgCccXn2HNBQvqrI9HCeySpgW7lIB+Sxa6XKqfudX8c2ir1F0UO1Qwer
 j6dLQZrPi66uCrFCSB2U1fmYkfi6+57/VayVEwp1Eena0N71ry60gEYj7qQRqBbxaoK7QEmr
 Tg8B1Ohx5TWBt6H8hJmZ7lZaMgh7U1v0GXEq0piM5bmI60Kakc2VQNxsguu0hx2Dt8Fis02t
 DYwywE0L6uE0VRHfjfe3JbqO7SRJHOgtBaoI7Xb3F3TyrP0su8G9eg4plP/vQqoCltq8nNp1
 MNQ2med4ZOCBRQbUJb4WEI6vxZgoLSSbi447oLSnXpiVMv8+hrLwdE0H60Izhi6ftFQGLyJH
 kn+HoxSBsSjLvArh0n8dggNb6hZ8K85Od/jduPTgvfxerw6w3T/0CIevNMYsArE7Sd3R+/W0
 oxQxviZ2lHCTDLglBK7tcuxn4lYZDYUF275yC7+BYcXaLchGORDQWqoPcCzwc1zwpD3XHsNv
 nuqHVAbw4mEfRSIblry9RJd3wIbrDb0/EnwhywxiDwvoqeFiWbryv7haQFBF2pFXmhkgn/zL
 ILyg91QDy3KJ0A50RCi40j93a1Soq9yenLSTUl/dC/zN2h+U6G0u9JueuZ34Ygz+WVSWeW4O
 xWBT6Ll5gEd2GXlFndfwzYyc3ervI/4llp0kjDVIHF2pXvfMcZ+oHWXrPnVX/1MxXwrQCdii
 D/YLkexNZ+l8J2YmozCvea3S2+6HscKK2+xl9zG7Xb9vDEiCAb3h/2pn9z7DQU2tE2zn8JnU
 ynFtle0Y4Xm0bi7LfMye0BpAFHm7M8pUop6k4Y2mNQRwS1A38/TpyBY1z6ud4wHisecJDIXS
 DUGwsDY+l3g0UxndDeSwp7hE2+ayY1nbsW7ZWUf3mQ86dpLAeGa9u8h/2M9r1ymoAbWefU4k
 C0azK5kzXcAgPwS/icpwD+cBL86AkRSeyDh3UftjZj2vOBMaWCjfKLlnm93h9O8F/evpg9GW
 XD2UogvF2l8448sVTCEmG224Ybidt7KaNsVvRDBiBbMgd9eL5cpn+YLjy5qairt+GcowOkhg
 VlyzIm36cKZfn518vvzUXs6fnXlItke8Tb3geNCk9aKisqxS455FGxDXYO0H6jxSnRI76uhb
 lzQVmRm+jDBRN+9VUee8Bs09SuVVcrxaDfOeT9Bio8/DBiFeB4F2VpSBm9l2MdmUFjtnpOpc
 V8ltGpIuRin8F0Vm7gubUWvFT2OwWXgIjYsFMrPdlwPsFwEvhqEd5TZtLw7HjkErMf480rSc
 CrBP1sOVSZTBQSFHwyxZODxo4aatbHJXKzgc7yUP9Ds4aRfT6valcjpi9U7uWzWZ4PWZSEqD
 uVniBoZGyknRoKDwG1JEXZf0ivJa4TzSA6U3Cpxo4j/9f3qXFiq/o6TE/5INt4p/RmqgKCFP
 urWhSBjKD8e2IlejXnPgKMS2lIfkUQMP3GkDKgAuCjRTanRhr4fDhgVbDl2PddJ6KR01xdEO
 MrSgNf4nrBiift9B1BAXF3n0sanAK5Ca3m6L0/CDV2XOa6uIDrW34fobKn6RbARxORYuhusu
 CqKRk/uOjPQ8luhHxurMOxKkGSaJEkE4dv7KEwyTzG+Cou6OXjZeJdtgDY7wKM5nCbPPG8Ya
 31ndl9V66eX5mVei+l+HGpI6jxkK/OFkmCX9bq9SN5evP11DyBzj+8f7m49zu4fySheR+Fu3
 gbWoMRvpV6OjeSFjDZqGkkryH4DlMeQsENuNL+MvIFHQmrB9QkR4H+4DhMXu516B9ept60am
 b2t3OrjbTxF9dzT584VAcPZfdmGPHQWOh3sADfIDQEBQFZD1EnagFFB1u6f/DuZo8piwnAJs
 IUDQPlXWQ5tfhv1IltoFpoOLcUuNg4=
IronPort-Data: A9a23:R03VJq0WVimfMooRKfbD5dx1kn2cJEfYwER7XKvMYLTBsI5bp2AEz
 TBKWDrQbveNYWP0LtkgPomwoxkBsJCDy9E3GgE63Hw8FHgiRejtVY3IdB+oV8+xBpSeFxw/t
 512hv3odp1coqr0/0/1WlTZhSAgk/vOH9IQMcacUghpXwhoVSw9vhxqnu89k+ZAjMOwa++3k
 YqaT/b3ZRn0i1aYDkpOs/jY8Eg246yo0N8llgVWic5j7Ae2e0Y9V8p3yZGZdxPQXoRSF+imc
 OfPpJnRErTxon/Bovv8+lrKWhViroz6ZWBiuVIKM0SWuSWukwRpukoN2FXwXm8M49mBt4gZJ
 NygLvVcQy9xVkHHsLx1vxW1j0iSlECJkVPKCSHXjCCd86HJW3/mye1QUh1pAYw33cMvLG5cy
 d8+ExlYO3hvh8ruqF66Yuxrm9hlM8Theo8S0p1i5WuAV7B8G8+FGviMvIMwMDQY3qiiGd77b
 tAadCEpQRDOeRxJNX8IBZh4kOrAanzXImIH+AnF+PpfD2777lRt6IX8AtrsSPepV9hUw1aau
 kGX4DGsav0dHIXClWTcqyzEavX0tSj8U4kTPKap8+ZjxlyV3G0aThMMPWZXutG8jVOiHc1SI
 QoY90LCsJTe6mSvRNPlYUPk/0KFkTk5A/dfAdEZzjqkn/+8DxmiOkAISTtIadoDvcAwRCA32
 lLho+4FFQCDo5XIECzGp+b8QSeaZXZMdzJqiTosEFNdi+QPtr3fmTrpar6P+oaHg8P4Hzv92
 T+HqkDSbJ1P0pBRv0lX1XbAmS6s7rLTRwQ84Bm/Y45IxgZ+eZLjeIGir1TWhRqhEGp7Zgna1
 JTns5HPhAzrMX1rvHHdKAnqNOz5j8tpyBWG3TZS82AJrlxBAUKLc4FK+y1ZL0x0KMsCcjKBS
 BaN5lMAtcYPZivyNv8fj2eN5yICkveI+TPNCa+8UzaySsMhHON61HwzORHNhggBbmB1zv9uZ
 f93jvpA/V5DVPg5lWPoLwvs+eZln2g/w3/eX5b201yu3tKjiI29Gd843K+1Rrlhtsus+V2Lm
 /4Gbpfi40gBDIXWP3eGmaZNdwxiBSZgX/je9ZcIHtNv1yI9RQnN/deKneh+E2Gk9owJ/tr1E
 oaVARIAlAum1CGcdG1nqBlLMdvSYHq2llpjVQREALpi8yNLjV+HvPhHJagkN6Iq7vJixvNSR
 vwIMZfISPdWRziNv3xXYZDhpcYwPF6mlCCfDRqDOTIfRp9HQxCW29nGegC0yjICIBDqvuQDo
 pqh9Djhf7w9eypYAv37VteT3nKqnH1EmOtNT0rCedZSX0P38blVES/6j95pAsRVNxnz/yaWj
 TiXJRIiocjMvI4H393bjo+Ur4qSMrVfH2gLO0L5/LqJJS3h0W77+rB5UcGMZiL4eFLv3beLP
 MF57qjbHqUcvVBot4FcLe5a/Zgm7YGym44AnxVWInrbSn+KVJViGyCi9utSvPRvwrR5h1OHa
 niX8IMHBYTTadLXK39PFg8Lde/Z6Oo1nAPV5vELIEnXwi970b6EcEdKNSm3ly1vA+ppAbwh3
 NselpYa2y6nhjouF+S2vCRe2mCPD34HCqscps47Bq3vgVEV0V1sW8HXJRL3x5CtUO9yFHcWD
 AWavpefuIQE9HH+KyIyMVPvwdtigY8/vUEW7V0aeHWMtNn3pt42+xxzqgYIbxln4ShG98lRO
 WFbEVJ/CovT3jVvhelFB3uNHSMYDjKn20XB8Xk7v0yHcFuNSUr2M3wbBeaB2Gs74lBsVGFX0
 5/AwVm0TAuwWt/62xUDfHJMqtvhfIRXzRLDksX2JPa1NcA2ThS9i5D/eFdSjQXsBP4wo0j1p
 eNK2uJUQo+jPA4yp5wLMaWr5Y4yejulelMbGepA+ZkXF17yYDuxgDiCC36gc/N3esDlzxWKN
 NxMFOluCTKOjD2DvxIKN54qerVUpsMk1PAGW7HsJFMFjYehkypUgMrQ2xX61UAWQIRIsMciK
 4nuWSqIPU6OiFB1xWLcjsl2FVCpQNsDZQGm4uGR9d8NNpMcsdNDdVM5/au0sk60bipm3UOwl
 yHSa5DGy9dNzdxXoLLtNaFYFSCYFMjWVtnUwDusst9LU8zDAf3OuywRtFPjGQZcZpkVZPhai
 pWPt4TR8H7enbNrTV3cpYaNJ5NJ6eq2QuBTFMD9d1tevCmaXf7T8wkxwH+5JbNJgeFiyJGeH
 SXgU/SJdPkRR9t5719WYXIHEx8iVoLGXp25ria59/mxGhwR1DLcF+ye9FjrUzBrRnddcdm2Q
 Ar5oO2n6d1kvZxBTk1MTe1vB5hjZkTvQ+06ftn2riOVFXSsnkjEgLb5iB488nvePxFoyiohD
 U7tHXAStSheuZ0kCPlctJFu+AIaBjBxjIHcu67bF8Fe01iH4KwudIzx8qnqzrlLnya02JyQi
 PTlcj45ESukNdhbWUyU3TkgNztzwsQRN92/KjFBE4Z4rcupLNvoPYaNPRuML5u7lvUPAQ1nx
 RwjFqXMAyWM
IronPort-HdrOrdr: A9a23:6fTykKBA/sCGiAnlHelo55DYdb4zR+YMi2TDt3obdfU1SKGlfq
 +V7ZcmPHPP4gr5JktPpTnwAsW9qBrnnPZICMsqXItKNzOIhILHFuFfBPPZsl/dMhy7zfRF3a
 NsN4B1Fd33CjFB/KLHyTj9KMw4yN2LtJi1ifvTi1dhJDsaDZ1I3kNDEB+SFkAzfgVcGpYjfa
 DsgfZvln6bYHwSY4CBCmMYWvWrnayvqK7b
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,268,1673910000"; 
   d="scan'208";a="97783858"
X-MGA-submission: =?us-ascii?q?MDEZmCWnXQ00QbDA66Ak66hTyqwu0WJZc/Wfa4?=
 =?us-ascii?q?pH/WJrQCxrc2DEYzvPtN04J+8YI93iQogevoLizPdWY4h3farRyb8kAt?=
 =?us-ascii?q?rXr+rJV7zeCEKfBh6WfxLmRIGKLlI/C1HkJ8vFJTRiGpDyEmbzoqzqI1?=
 =?us-ascii?q?WPZ9dxBpkPQkKdPtItAlL8xg=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 15:20:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679062814; i=markus.elfring@web.de;
	bh=SCwrapoV90k7PPQXDoRWVOZ47w9dirURaRogquQ3emo=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=SO2TTirRqLtWUoQK3T4bGukkQlAYjuEKPJP0lFBahhrqJXuG3bMYtpHNgV0mkOi1F
	 j+0cYOuBLANaW7elMld22xgrPpLXvMTHNmxDGYCZj9m+tPM7CkzmXSulRU87ubT5kh
	 DR//Knp8zsjg67Vz0UWO6v/wQn2ybDnZk5iG5m7O9j/FWDsuzx3ey9mexbXZ7J6rkK
	 fUmsICMvvTIzuPD5rtkRYP5FKwjEeLzTHm+lho6XD7B50elY5InErxv0LQGdK/hXdt
	 ve7/xzmCzgHJ+VWbO7aVE1v/tai1MqSJO9V0HFM2jhsuoutFnNaDChOK8XBD5kAvN9
	 YJT2WK5BWtlzQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MF2gW-1pjjS22i6a-00Fmzu; Fri, 17
 Mar 2023 15:20:14 +0100
Message-ID: <a01643fd-1e4a-1183-2fa6-000465bc81f3@web.de>
Date: Fri, 17 Mar 2023 15:20:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
To: Nathan Lynch <nathanl@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 kernel-janitors@vger.kernel.org
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Paul Moore <paul@paul-moore.com>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <0981dc33-95d0-4a1b-51d9-168907da99e6@web.de> <871qln8quw.fsf@linux.ibm.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <871qln8quw.fsf@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CIqQ89eGA+84OKhR0u04OjAu5Q0Bl7u7oC4Tlc8vFMvrrqZUMoi
 OKxoF+lovWdcDuCsiU10l4UWIJo9ZTDwa+FwNcRxwZ+vgwFRNd8yjjjX7otII4+B8f/oKmC
 IoH3lEmVCRAimgsaSCe6egrfLQfOSIqWAPoWIYHbRdBbP/o0K+Z39MxXsJhUHzadOZjKpA5
 5cUVNqWeYbCmSi6/TKzXA==
UI-OutboundReport: notjunk:1;M01:P0:My+PTZpEtgU=;4WmiQXh32eopvYD78DtZ+3NJZgM
 it0uaXXwFy/iHvv3/8j6dtczMrC4AoQmuuPMe7LpN0r572smn5Pw43Z6+Ixlltty2tsBE9SW8
 EuF5Bg1JoEdRqYhbtJGhpWkVaGHh8nF9quOgTazRxicEYjZYsK6PQGFEujxFvlWFZt7WDtbKo
 9MW6Ek1qtIy2f/rNVtK6Or0xz81RwC6lxZKpOPi2sfOHfioVPOfRHdlKcXwm50RJyn6lsytRp
 xtoChDoJiJrR1dzsjKw0GNHD/dlFb3tGJWdqjh+fybbG+sKrK925Z8b1MdG40TR48bYcITw3O
 FJVcB+UCcCg1HTbYFE1ATj+yWcdbx0NiuDXDyrDLcdP3XjdxVK2S8jHVKsysXmQnZWAk/mweB
 SFYF5HUM788Ihblw7iWtUBqWP1tdJ9/Fxx+xd3ve7cJMqxMQEM8g9geHhm5mU+Ldgr7nxm5I+
 +m7v+HIBpEOtOPI+AqSVCxUJiaCiaHzqNEcL4evhHUuXugIAb9/R7JcBrC3fOMsUa/RYB/J+j
 jpKXCmnwh+0hXMFXRMSSfPJytjJj9REQclPkjeHkwseKvHynuUBpJb/rMu1/RxigR7yijtW0g
 g9WcVLCDRhaTngbPDKHafZvLUkeZMB1EV6Baz4hrd3/GiEZabJwa48mU6BYsokCTFPOGqEc+g
 j0HjGHRLOiBufWUJOxOhYcxsa7pkXQDSBEoyDPpkJaSDu7UqY2HLwuP0gaxrRQEk6PDH0HOyA
 S/eaaHU0b4vbVq4qZTFiEMVVXXD7RYc66JJnjjB9j0peBQubcFu09DN6OGVPnO1KTXXqIVyZE
 kjOh+ofrT3mk/3jhrphGcMJ/EBMyuCOojTIRzFZxvPQ8Umr3oWlmab0RL6LLswGHBbKfjoJfG
 nf3wIV9zYp7VqEpntkbcVt6A8vkmpWQxRr4PWIKWFItjYjIQPSlZUuVmtgbGE2Bz14F0XdBGc
 thKJUg==
Subject: Re: [cocci] powerpc/pseries: Fix exception handling in
 pSeries_reconfig_add_node()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 893
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/a01643fd-1e4a-1183-2fa6-000465bc81f3%40web.de>

>> The label =E2=80=9Cout_err=E2=80=9D was used to jump to another pointer=
 check despite of
>> the detail in the implementation of the function =E2=80=9CpSeries_recon=
fig_add_node=E2=80=9D
>> that it was determined already that the corresponding variable containe=
d
>> a null pointer (because of a failed function call in two cases).
>>
>> 1. Thus return directly after a call of the function =E2=80=9Ckzalloc=
=E2=80=9D failed.
>>
>> 2. Use more appropriate labels instead.
>>
>> 3. Delete a redundant check.
>>
>> 4. Omit an explicit initialisation for the local variable =E2=80=9Cerr=
=E2=80=9D.
>>
>> This issue was detected by using the Coccinelle software.
> Is there a correctness or safety issue here?

I got the impression that the application of only a single label like =E2=
=80=9Cout_err=E2=80=9D
resulted in improvable implementation details.


> The subject uses the word "fix" but the commit message doesn't seem to i=
dentify one.

Can you find the proposed adjustments reasonable?


> Can you share how Coccinelle is being invoked and its output?

Please take another look at available information sources.
https://lore.kernel.org/cocci/f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de/
https://sympa.inria.fr/sympa/arc/cocci/2023-03/msg00017.html

Another command example:
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-patched> spatch --timeo=
ut 23 -j4 --chunksize 1 -dir . =E2=80=A6/Projekte/Coccinelle/janitor/show_=
jumps_to_pointer_check.cocci > ../show_jumps_to_pointer_check-next-2023031=
5.diff 2> ../show_jumps_to_pointer_check-errors-next-20230315.txt


Regards,
Markus
