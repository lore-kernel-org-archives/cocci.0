From: hlovdal@gmail.com (=?UTF-8?B?SMOla29uIEzDuHZkYWw=?=)
Date: Thu, 27 Sep 2012 18:30:01 +0200
Subject: [Cocci] Help with SmPL
In-Reply-To: <CA+MoWDrymuTRRiQXcN6OVmPacFXDE=6zZazG7peBPEGW_ZRk_w@mail.gmail.com>
References: <CA+MoWDpBor-e+69ioxPH-kWcdnd8iYE3E9aXjC79dNO+_COxeg@mail.gmail.com>
 <501BEA35.5030008@redhat.com> <501BFA96.6080803@metafoo.de>
 <alpine.DEB.2.02.1208031832490.2827@hadrien>
 <501C0878.1010906@metafoo.de>
 <alpine.DEB.2.02.1208032309470.1928@localhost6.localdomain6>
 <CA+MoWDrymuTRRiQXcN6OVmPacFXDE=6zZazG7peBPEGW_ZRk_w@mail.gmail.com>
Message-ID: <CAACXqO8GNr9cknk-K5E58JUhQd3r0is6mkX_kzSsjF=-qt9X1Q@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 27 September 2012 17:29, Peter Senna Tschudin <peter.senna@gmail.com> wrote:
> 2 - Empty switch case / default, like on:
> diff -u -p a/drivers/media/usb/dvb-usb/cinergyT2-fe.c
> b/drivers/media/usb/dvb-usb/cinergyT2-fe.c
> --- a/drivers/media/usb/dvb-usb/cinergyT2-fe.c
> +++ b/drivers/media/usb/dvb-usb/cinergyT2-fe.c
> @@ -60,7 +60,6 @@ static uint16_t compute_tps(struct dtv_f
>         case FEC_1_2:
>         case FEC_AUTO:
>         default:
> -               /* tps |= (0 << 7) */;
>         }
>
> In this case, if the semicolon is removed, gcc complains:
> drivers/media/usb/dvb-usb/cinergyT2-fe.c:62:2: error: label at end of
> compound statement
>
> Any ideas?

Gcc complains because it finds a label not followed by a statement
(the removed semicolon served that role before).
For this specific case I would remove the semicolon after the comment
and then insert a break statement after, e.g.

        case FEC_1_2:
        case FEC_AUTO:
        default:
                /* tps |= (0 << 7) */
                break;
        }


BR H?kon L?vdal
