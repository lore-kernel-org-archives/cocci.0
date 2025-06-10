Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39766C5B552
	for <cocci@archiver.kernel.org>; Tue, 10 Jun 2025 06:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=QtGmO32MWmv2oqQt77RtwekQKB2W8DvItptTZDgUe3c=;
  b=q+hUCsbv/W48gTWgRKhmBsGbgLfngBNFNBhkNpT1YKFTtlWZNp7kUChX
   AiJrRh5bVvt3K/406x3hgEMKIvS7zwlAcZcT5unW1GuMdljcjuDck6vLQ
   eqOkfjBRch4qq8QLTE7yDff8UYGAPDaAXzRxt6gRz4fxuPHNeTbWmKzvS
   s=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.16,224,1744063200"; 
   d="scan'208";a="225961691"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Jun 2025 08:11:24 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1DD71E02E4; Tue, 10 Jun 2025 08:11:24 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 39EFBE0131
	for <cocci@sympa.inria.fr>; Tue, 10 Jun 2025 08:11:19 +0200 (CEST)
IronPort-SDR: 6847cc7c_WdzErxIiw5JaS1VfHi5jXHDRGSybSDw9av13UDZ/bc1mXWq
 zZS48DR2SOS/CZEPOxBsjQqMQBcE7+ohijHkjTg==
X-IPAS-Result: =?us-ascii?q?A0FuAAApzEdofgQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UEFAQELAYJDgQBaMwQLSQSEUY9QgiEDhDuTf4QHgVWBfQIPAQMBDUQKAQIEA?=
 =?us-ascii?q?QEDBDiBVIJ0AotlAh4HAQQyBw4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBA?=
 =?us-ascii?q?QIEBgECEAEBOwcOCQExhXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CDTpEAgEDI?=
 =?us-ascii?q?wQZAQERJgEPHwEFAiYCAlYGARICAQGCfgGCIQEGEAEDMgcNriR/M4EBggwBA?=
 =?us-ascii?q?QaCadd1HywiWIFlAwaBGy4BhWyCYwGFbDuEPCcPgVVEgRQBJ4NBhGmDNYJpg?=
 =?us-ascii?q?iiBAhSgfoFKHANZLAFVExcLBwWBMDMDIAo0FAQZAhQcARIPBBYyHYINgi1Pg?=
 =?us-ascii?q?h2CEnCBF4IlhTmBI4RJK0+EJXxMWoNfJHIPBxpAAgELbT03BgMLGwY9mGiDb?=
 =?us-ascii?q?wEBUjsBKxcJJoIEkw4Rk2CfIjQHgjiBZoFkDIotlTsGEy+XSw4GkwIuh2WQc?=
 =?us-ascii?q?SKLbIF5mzGBbwIxgVwzGiSDNhM8AxkPjiE+g3WEYIoqAagbQTUCATkCBwEKA?=
 =?us-ascii?q?QEDCYVGAQGLA4FLAQE?=
IronPort-PHdr: A9a23:KTr/iBxkGSD7VOTXCzIowlBlVkEcU1XcAAcZ59Idhq5Udez7ptK+Z
 xeZvawm1QeSAM2bs6sC17GM9fi4GCQp2tWojjMrSN92a1c9k8IYnggtUoauKHbQC7rUVRE8B
 9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUhrwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9I
 Ri4owjdrNUajZZtJqos1hfErHtFcPlSyW90OF6fhRnx68mu8JJ57yhcp/ct/NNcXKvneKg1U
 bNXADM6Pm4v48HlqQfNRhaV6HsGVWUWnBtIAwzb4xz/Q5z8rCj0uPdj1SeDJcH5Qqw6Vjqk7
 6dwVR/nkzwHOCIj8GHWkcN/kqRWqw+8qhNlwo7UZIaVNOdifq7YYNgXS3ZNUtpXWidcGY63c
 ZcBAPQdMuZZt4n9pkUBrR2iBQm3GejjziZEimLq0aEm1ugsFxzN0g49ENIUqHnar9v7O6gcX
 u6ozKfG0yvOb/1U1jjh54bFaQwhoeiWUL5sbcbd10siGgXYhVuQs4zlODaV2/wKvWeB9epgV
 v+vi3U6oA9+pjivyN0siojPhoIa11vJ8iJ3z5wvJd27VU57esSoHpRUtyGULYt2Q8UiQ25zt
 Sc01LIJooS3czUUx5k+wRPUdvOIfZSS7B35SOaRPSl3hGhjeL+niBi/8lSsx+PyW8S10VtHs
 DRJn9nCu3wQ0xHd5MuKRPty8EqlxTuDywHe5+FaLE07lqfWKYAsz74+m5cNvkrOHin7k1j4g
 q+Rc0Ur4Omo6+L/b7XluJCcLYl0hR/6Mqg0ncy/G+s4Pw4TVGaY4eSxzKPv8VDnTLlQkPE6j
 KvUvIrHKckbvKK0DBdZ34Is5hqlATqqzc4UkHgDIV5fZR6KjIbkNlfTK/3mCfe/nk+skCt1y
 PDcI7PhA5TMIWbbnbv9e7t29lRSxxApzd9F4pJZErEBL+z3Wk/2rNHYCxg5MxGow+r9BtRyy
 JgRVXiSDaCHKK/SsFmI6fwzI+SUeoMZpSjxJ+I76/Lwj3I1g0IRcKmz0ZYYcHy4G+5pI0SdY
 XrimNcBFmIKsxI5QuPwkl2CUiNTZ22oU6wz4jE7BpimDYbFRoCim7GA0jm0EYZMam9bFF+AC
 XHoeJ6cVPcWdC2SOtNhkiADVbW5VoMtzQuuuxPiy7p7MurU/TUVuo7k1Ndp++LTlAo/9Sd0D
 sSYy2GCVXt4nmIORz8s3aBwu1ZxylmZ0fswv/sNHNlfovxHQi8+NIXA1Kp0Ed3/Vg/afcuOU
 BChWNriST0rT5c9zsEDZ255Gs6+lVbNxSenD7IOlKCMHNoz6K2Yl1H1KtY153vb36kslRFyS
 89CJWSgiqNlsQTeGoXJnl+xnqOmM68b2XiJvE6HwHrGnFxeX0YkWKHITTYfe03Zhd386gXJS
 Lr4TfwOLxFIw8+EJqwCUtztiVxHDKPqJc7XaWO3l2D2HReMwrqNRIPvdyMW2yCLTAAvkxoS5
 mqHPA52Jbmnom2WWDduD1P0f0Ll9699r369T0AcxgSGKUZm0uzxsjIcg/2RT7st064YtT1p/
 zl9Glew2/rYBcWEo0xqfPMYKf80/lZLnUvYrQh8M9T0JqF4gl8Tfyx4ukrv01N8DYAW1YAGq
 3YrygtxYYGRy0FMaCib3NikNrrSK2/z/1asYrXE107F09e+86IDrv8/rgOn9C+gEEUw83Qv4
 cRSmy++64/QHUwgTJXZW0M7sRN9oueeKgk0/ZnFnUJhN7WwuznOk4YpDfE/21C/ctFDNKqCG
 Cf7FsFcDM+rfqhiv1WuJjYFdLRJ6agsMsWpMf+H8KeuMKBrmzfwySxi6Zp81Qqo9i97TOXJ0
 pIBxLnM2wKdVjC6iFaktcb8mI1AYTY6F2+zjyPjAdgVLpd1eI8NQUOva5mtwdB3gdjpWlZR8
 VLlDFQDjovhQhuXaFr0lTNdyVgauzTzgiq9yDp9uz8nsa6bmifOlaCqSB0CckVLWW9txQPnI
 Ym9j8sHVU7uZAg0khSN7EP2gaNcofI7Z1baUEFFNwz3KSk2baKhsLfER89JwJotvWNcV+HqM
 n6ATbuohhIA0D74V0Zayio6cT7i7rDwhR9nkySwKHhprXzWUd59z1HT6YqPFrZqwjMaSXwg2
 nHsDV+mMozspI3M/3+imuW3Vmb7E4ZWbTGu14SL8i2y+WxtBxS72fG1gNzuVwYggmfgz9c/c
 yLOoV7nZ5XzkbygOLdCd1NrGUS6xs50AIB4naMviZtW1XVJzo6N8y8/mHzoec5exbq4aXMMQ
 TARxNuAxQH/21B4aF+NyZj4UHq13cZrIdW3MSsNwixoycdMBe+P6aBc2yt4pl3ttQXKff10h
 SsQ09Mr72MGxf4Eskwhw01xG5g0Gk9VdWzpnhWMtZWlqblPIXyoev623VZ/mtaoCPeDpBtdU
 TD3YMVqGyg49ch5PF/WtR+7ooj5ZNnda84SvRyIgl/BieZSMpc4ivsNg2JuJ2v8uXQvz+Nzg
 wZp2Nm2u42OKmMl+6zcYFYQEzTvZN4IvBzpg7xfmMm+wI2lWJlsW30KUJbuUfO0AWcKr/20f
 w2KETA6tjKaAe+FRFXZsh056SuSVcz4UhPfbGMUxthjWhSHcUlWgQROGS4/goZ8DAehgsrob
 EZ+4DkVoF/+sBpFjOxyZHydGi/SohmlbjAsRd2RNh1Tu0tn7l3WLNfYw+Z9BSBe8bW+oQbLJ
 mHRNGEqRSkZH1eJAVzuJOzkwNDa8PWDQMe6IeHPZ7qmtuFUEfuFj8HKsMMu73OHMcOBOWNnB
 vsw1x9YXHx3LM/eni0GVy0dky+lg9eznB6n4WU3q8m+9K6uQwfz/c6VDLAUN9xz+hewiKPFN
 uiKhS8/JywKnp8LwHbJzvAY0jtww2lLfiOuDK9GmCrDVqPWlYdIAhRdZy47OMZT7q061xVAI
 oaB04mzjOQnyKdoTQsNXEepgsyzYM0WP2yxUTGPTF2GMriLP3yDws36Z7+9VawFiexVsxOqv
 jPIW0TnPzmFi3zoT0X1aLsK1nvEekUD/t3uF3QlQXLuR9/ndBChZdp+jDlshKYxmmuPL2kXd
 z51b0JKqLSUqyJemPR2XWJbvR8HZaGJnTiU6+7AJ9MYq/xuV25RnvhZ/W985r9b9iBCS9Rql
 SGUotMk8DTE2qGfjyFqVhZDsGMBoYuRvlh5f4jd+INBX3ns4x8Hq2mdQUdvxZMtGpjkvKZez
 cLKnaT4JWJZ8t7aysAbAtDdNMONNHdyeQqsAjPfCxEJCCK6LWyKzVIIi+mcrzfGy/py4oipg
 pcFTaVXEUA4Bu9PQFowB8QMed9+DDYjjKLdk8MCo3az5BCDQcJHotXXWPWIHvz1JHCGgLMCa
 xZto/uwJNYWMZDnnkZld19xkcLVFkCWUd0Fq39kaRIo5U5W+mV6TStq0kTpM0Wm53p2d7b8l
 0wzjRZiJO82/zD2+xFuL1zG/W07l0x5j9zhhXr5nCfZCqC2UMkWDiP1sxJ0KZbnW0Nvagb0m
 0V4NTDCTrYXjr16dGkthhWO8Z1IUeVRS6FJenpyjbmeeuko3FJAqy6m2V4P5O3LDoFnnRcrd
 pjkpmxJ2gZqZto4baLKI68Bwl9Vj6OI9iims4J5iBcZPFoI+XiOdTQgvUsVKv85KiDu8uEto
 Q2Olj1feXQdAvonpvU5kyF1c++Ezi/mz/tCMhXrbrbZdfnG/TGd05LbJzF4nlkFnERE47Vsh
 MIqck7OElsq0KPUDRMCc8zLNQBSacNWsnnVZyeH9+vXkvcXd82wEP7lSeiWueMamEWhSUwMF
 p4P899HM52iykDeIu/4IbRDxRhnt2GJbB2VSe9Efh6GimJNu8ak0Jp+xpVQPBkYBnhhdzq67
 PDbq0V55ZjLFMdzaXAcUIweM3swU8DvgC9VsUNLCzyv2/4YwgyPh9cdjiHXESW6cNdpIvuZN
 0sE4D6e5jg1taS72we/GnD2OGzwc9hv6Ien1A==
IronPort-Data: A9a23:x1lMrqNTYzaH5fzvrR2Qk8FynXyQoLVcMsEvi/4bfWQNrUp0hWEAz
 WEdD27QOvnYN2L1ft5+YYzl9kxXsJDcxodiQHM5pCpnJ55ogZqcVI7Bdi8cHAvLc5adFBo/h
 yk6QoOdRCzhZiaE/n9BCpC48T8mk/vgqoPUUIbsIjp2SRJvVBAvgBdin/9RqoNziLBVOSvU0
 T/Ji5OZYQHNNwJcaDpOtvrd8Us35ZwehRtB1rAATaAT1LPhvyJNZH4vDfnZB2f1RIBSAtm7S
 47rpF1u1j6xE78FU7tJo56jGqE4aua60Tum1hK6b5Ofbi1q/UTe5EqU2M00Mi+7gx3R9zx4J
 U4kWZaYEW/FNYWU8AgRvoUx/4iT8sSq9ZeeSUVTv/B/wGXdfFDU+8VkKX0IArVb1d9pLFhP+
 doHfWVlghCr34pawZq+TfRwwNsuJo/nMevzuFk6lGufV6x5B8meBfmiCdxwhF/cguhrFOzde
 tFfRD5hdhXGbDVQN11RBJ9WcOKA3COiImMB9gzPzUYxy0f+9gZpz5HxDNXya87SSIIFvxqcr
 0uTqgwVBTlBaIzHkmramp62vcfEmijwWaoJBbig/7hrhkeSzyodEnUruUCTpP6klgihVtgZJ
 0F8FjcSQbYa70OAduHNVTiEnkG8/TElRfdpEuEc91TYokbL2DqxCm8BRz9HTdUpss4qWDAnv
 mNlefu3VVSDV5XKEBqgGqeokN+kBcQCBUMvDRLooCMA5MT/5p4+hFTDQ76P8ZJZbPWlSFkcI
 BjT8kDSYon/a+ZWhs1XGniZ2lqRSmDhFFJd2+kudjvNAvlFTICkfZe0zlPQ8OxNKo2UJnHY4
 yRVx5nFvb5VUcjQ/MBofAnrNO70jxpiGGKD6WOD47F8qGT8k5JeVdsBuWAlei+FzO5fIW+yO
 ic/Rj+9FLcIYCvyNv8oC25AI8Uty6/7Xc/oPs04nfIeCqWdgDSvpXk0DWbJhz6FuBF1zckXZ
 83HGe7yVytyIfo9klKeGbxHuZd1nX9W+I8mbcqlp/hR+eDBPCbNIVrEWXPSBt0EAFSs+l+Pr
 4oOaZDamn2ykoTWO0HqzGLaFnhSRVBTOHw8g5w/mjerc1Q4SlIyQeTc260gcIFDlqFY3LWAt
 HKkV0MSjBK1iXTbIE/YIjpueZH+b6ZZ9HgbBC0LOUr3+n4BZY300rwTWaFqdpYa9cti78VOc
 d87R+u6DM9icA/3owYmUcGlrahJVgiaugaVDi/0PBk9Z8FBQiLKyP/Ffyzu1nI8MQuqh+QDo
 pmL9ADScbwcTStMUefUb/OOyQuqnH4/wehdYWrBEuNxSm7Nrrd4DjPXteAmBf0MJTHo5Cqo5
 yzPDTg2/eDy8pIIqv/XjqW6nqKVOupZHHsCOVLE7LyzZBLozkD6zaBuCO+3LC3gDkXq86CfZ
 MJQ/fH2ENsDuH1o64NcMbJa/ZgS1uvVhY1x71pbRS3QTlGRFLlfDGGM3pBPuo1z17Zpg1aKd
 XzVyOZKG4eiGZ3DK0EQFjoHf+7Y9PAzmxvu19oXDnj+xhdK+OugbR0PETiK0DdQPZlkArMDm
 O0BgvMb2ya7qxgtM+uFsBxqynSxHiQ+dJsj574nA97Nqws0y1t9T4TWJQ3o7bquNdhdEEkYD
 QWFpajFhrgG+EvmdkA3NHnS3NhygYYFlwBKwWQjeXWIuIvhrd0m0CJB9Q8YSlxu8SxG9OZoK
 E1HClZQJ5jSzwx3hcNGYX+gKztBCDKd5Eb17VkDz0/dcGWFSU3PKzcbFduW3UVE7V9ZQCdXz
 IuYxEnhTzzuWsP7hQk2eEx9rs3cXc5DzRLDlO+nDva6McEDOxS9uZCXZE0MtxfDKuEyjheep
 eBVocBBWZeiPisU+6AGG42W0IoLcy+9JUtAfOpA+Z0YFmSNaRCw3jmzc3qKQP1vHMCT00GEC
 J1JHPltBjCezyeFqw4JCZEce4FUmOEb3/tcW7fJC1NfjZ6hgGtIiq/Azgn/m24hfPt2m+kfN
 I76VmyPA06Qt1Ruik7Pq8hOBTvhbfJZPz/D/f2H39gIM7khs+hcV144/ZXpnneSMSphpwm1u
 iGabYDo7uVS86ZetKqyLbdmGCO1NsHWeNmT1QKO7+R1ctLENPnRuzMvqlXIOxpcOZ0TUY9Vk
 YuhncHW3kSfmpoLSEHcxoe8EpdW6fWIXOZ4Ntz9KF9Yl3CgXO7u+x4yxHCqG6dWkd9y5tiVe
 CXgUZGeLeUqYtZ6wGFZTwN8EBxHUqT+UfrGlBOH9v+JDkAQ7BzDINaZ7kTWVGB8dBITGpjAG
 wTx6ueP5NdZkdx2PyU6JcpaWr12HFyyfpEdVYzBhWHNRC3gyFaPoaDrmhcc+CnGQCvMWtrz5
 ZXeAAPyblKusaXP18tUqJF2ogZRNntmnO0sZQgIzraaUdxh4LIudozx8KnqC624VgT304zkI
 i7AZi0uBE0RmNiCnQrUuLzessW3X4Ti+esV4hQ28knSZyre6EaoHu567ik5i5tpUmKL8QxkQ
 O3yPlXvMxL3zpwBqSP/IBCkqb8P+842DU7kNawwfwIezvre7Xg3OKRdITdw
IronPort-HdrOrdr: A9a23:+Apa7a0nkp7hsDI+FgzyfQqjBGYkLtp133Aq2lEZdPWaSL38qy
 ncpoV96faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SPzUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyVMbEQt6bHCWeDYrQd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-Talos-CUID: =?us-ascii?q?9a23=3Asw5BSWtbLMfWu7mtmTmthj7/6Is+fVbl9EfaBnO?=
 =?us-ascii?q?GNl4qZ4SLZGaR9IV7xp8=3D?=
X-Talos-MUID: 9a23:dPnf7AolbYZfqmPtLH0ezx5PDs1w/I2yNE8qgIdeto7UFHB0Mh7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,224,1744063200"; 
   d="scan'208";a="225961662"
X-MGA-submission: =?us-ascii?q?MDFroN+5tq94eMDmlWBkAhsIgZYJ5iLuXGbAOy?=
 =?us-ascii?q?Di6siotgFbk7HDRKC5njjOoYhSc//6oPN+iqT57Oevnb6iTpOMSVL+Au?=
 =?us-ascii?q?0nS+f3OwPYAPmk5vw2woEtPs+ssrvkQQpU18NFKc4Fzn39Clk8Xt8AyK?=
 =?us-ascii?q?oPwEtegqKDzKMzZkC5qHd4Iw=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 08:11:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1749535856; x=1750140656; i=markus.elfring@web.de;
	bh=QtGmO32MWmv2oqQt77RtwekQKB2W8DvItptTZDgUe3c=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=J0D2imuxvWewcwUecaFheVVsE9H0rOLva2MNy01LnEMIGVIiritGDORnZqpG5Axb
	 AwOFYLJ95ys6GhgRc05BanC2d7FXxD2LAxH0KuJ5jCxmyl8peCbmxWHHc2QMiy2Gr
	 4LGTIQLakP+yVfUmPvDaJT++f26L86nBCqmP6bqirHW0+GtQ2OFDbeYgtHR+FPmp9
	 DUtND2xidP8CxcsZuB+ai/aRZCCVCQMLyxBi7LsuFe2O9O/7CvIR5kcmAL6JFcwhB
	 1ruEKMCIyCAH02+8fMMQrO8QpX23wuttCa0BMbR7VuMi4dw7chbu32wtLDOgf5y2U
	 1WzSS4zIyya8LTT/FA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.183]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MpCmZ-1vBRx23Ai7-00fv95; Tue, 10
 Jun 2025 08:10:55 +0200
Message-ID: <8684e2ba-b644-44c8-adf7-9f1423a1251d@web.de>
Date: Tue, 10 Jun 2025 08:10:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>, Alex Hung <alex.hung@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Dominik Kaszewski <dominik.kaszewski@amd.com>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
 Roman Li <roman.li@amd.com>, Simona Vetter <simona@ffwll.ch>,
 Tom Chung <chiahsuan.chung@amd.com>, Wayne Lin <Wayne.Lin@amd.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 lkp@intel.com, oe-kbuild-all@lists.linux.dev, llvm@lists.linux.dev,
 cocci@inria.fr, Melissa Wen <mwen@igalia.com>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <e6656c83-ee7a-a253-2028-109138779c94@web.de>
 <ea0ff67b-3665-db82-9792-67a633ba07f5@web.de>
 <32674bac-92c2-8fc7-0977-6d2d81b3257f@amd.com>
 <da489521-7786-4716-8fb8-d79b3c08d93c@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <da489521-7786-4716-8fb8-d79b3c08d93c@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:80O+haoG28pLodlT+TgNmlm05U3XWpmk4KtOLEIQOSYnyPhhLn8
 wyVp3nwi4WuqC9aKHEhr5Xp90vM+pk6RiWNYxiQmqJXFenBxq1AnKA4FwdcdApHeWPyKD8U
 wIRTKwTaBHCE8mk3OcImE11iC4V5mvvs6MBtqYF0WzJ67BEgNw5oZakajX7kiqtPadslbcK
 YmboKwjmxDmsXz1BK4b5A==
UI-OutboundReport: notjunk:1;M01:P0:zFF8mO0KoK0=;rr/lpWVNFVg7xG8a9GYPYrI5jmb
 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
Subject: [cocci] [PATCH v3] drm/amd/display: Fix exception handling in
 dm_validate_stream_and_context()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2751
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/8684e2ba-b644-44c8-adf7-9f1423a1251d%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 10 Jun 2025 07:42:40 +0200

The label =E2=80=9Ccleanup=E2=80=9D was used to jump to another pointer ch=
eck despite of
the detail in the implementation of the function =E2=80=9Cdm_validate_stre=
am_and_context=E2=80=9D
that it was determined already that corresponding variables contained
still null pointers.

1. Thus return directly if
   * a null pointer was passed for the function parameter =E2=80=9Cstream=
=E2=80=9D
     or
   * a call of the function =E2=80=9Cdc_create_plane_state=E2=80=9D failed=
.

2. Use a more appropriate label instead.

3. Delete two questionable checks.

4. Omit extra initialisations (for the variables =E2=80=9Cdc_state=E2=80=
=9D and =E2=80=9Cdc_plane_state=E2=80=9D)
   which became unnecessary with this refactoring.


This issue was detected by using the Coccinelle software.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202506100312.Ms4XgAzW-lkp@in=
tel.com/
Fixes: 5468c36d6285 ("drm/amd/display: Filter Invalid 420 Modes for HDMI T=
MDS")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--

V3:
* Another function call was renamed.

* Recipient lists were adjusted once more.

V2:
* The change suggestion was rebased on source files of
  the software =E2=80=9CLinux next-20250606=E2=80=9D.

* Recipient lists were adjusted accordingly.


 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 20 ++++++++-----------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/g=
pu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 78816712afbb..7dc80b2fbd30 100644
=2D-- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7473,19 +7473,19 @@ static enum dc_status dm_validate_stream_and_conte=
xt(struct dc *dc,
 						struct dc_stream_state *stream)
 {
 	enum dc_status dc_result =3D DC_ERROR_UNEXPECTED;
-	struct dc_plane_state *dc_plane_state =3D NULL;
-	struct dc_state *dc_state =3D NULL;
+	struct dc_plane_state *dc_plane_state;
+	struct dc_state *dc_state;
=20
 	if (!stream)
-		goto cleanup;
+		return dc_result;
=20
 	dc_plane_state =3D dc_create_plane_state(dc);
 	if (!dc_plane_state)
-		goto cleanup;
+		return dc_result;
=20
 	dc_state =3D dc_state_create(dc, NULL);
 	if (!dc_state)
-		goto cleanup;
+		goto release_plane_state;
=20
 	/* populate stream to plane */
 	dc_plane_state->src_rect.height  =3D stream->src.height;
@@ -7522,13 +7522,9 @@ static enum dc_status dm_validate_stream_and_contex=
t(struct dc *dc,
 	if (dc_result =3D=3D DC_OK)
 		dc_result =3D dc_validate_global_state(dc, dc_state, DC_VALIDATE_MODE_O=
NLY);
=20
-cleanup:
-	if (dc_state)
-		dc_state_release(dc_state);
-
-	if (dc_plane_state)
-		dc_plane_state_release(dc_plane_state);
-
+	dc_state_release(dc_state);
+release_plane_state:
+	dc_plane_state_release(dc_plane_state);
 	return dc_result;
 }
=20
=2D-=20
2.49.0

