From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 22 Aug 2017 11:28:59 +0200 (CEST)
Subject: [Cocci] Comparing statement lists with SmPL
In-Reply-To: <fda11784-5ed9-33ae-7beb-b5714abb11bc@users.sourceforge.net>
References: <aff3ee47-e4cd-af52-1a66-304f36ddc1ed@users.sourceforge.net>
 <alpine.DEB.2.20.1708151930140.4600@hadrien>
 <69d615e4-0f62-2289-dd59-97c625ba47e8@users.sourceforge.net>
 <76e2fbf5-4812-18eb-2968-53019d97ab14@users.sourceforge.net>
 <alpine.DEB.2.20.1708152208320.2049@hadrien>
 <be855581-e22e-2b58-8565-68412ae590b3@users.sourceforge.net>
 <c5f3c8db-e5ec-47c1-3d84-8392a7101645@users.sourceforge.net>
 <alpine.DEB.2.20.1708172043460.2068@hadrien>
 <b4451f01-e10a-c0f3-91ff-f49e185b3644@users.sourceforge.net>
 <alpine.DEB.2.20.1708172130300.2068@hadrien>
 <fda11784-5ed9-33ae-7beb-b5714abb11bc@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1708221128420.3178@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 22 Aug 2017, SF Markus Elfring wrote:

> >> * Are there further development challenges to consider for the safe identification
> >>   of unique statements by metavariables?
> >
> > If you want to ensure that two metavariables match things
> > in different places, then put a position variable on each match
> > and use apython rule afterwards to discard the occurrences that
> > are both in the same position.
>
> I imagine that such an approach can only matter if there will be
> several SmPL rules involved.
>
>
> I have tried another variant out for a source code analysis.
>
> @duplicated_code@
> identifier work;
> statement s1, s2;
> type T;
> @@
>  T work(...)
>  {
>  <+...
> *if ((...) < 0)
> *{
>     ...
> *   s1
> *   s2
> *}
>  ...+>
>  <+...
> *if ((...) < 0)
> *{
>     ...
> *   s1
> *   s2
> *}
>  ...+>
>  }
>
>
> elfring at Sonne:~/Projekte/Linux/next-patched> XX=$(date) && spatch.opt -timeout 34 -j 4 --chunksize 1 --sp-file ~/Projekte/Coccinelle/janitor/show_same_statements3.cocci --dir sound > ~/Projekte/Bau/Linux/scripts/Coccinelle/tuning1/next/20170803/same_statements3+.diff 2> ~/Projekte/Bau/Linux/scripts/Coccinelle/tuning1/next/20170803/same_statements3+-errors.txt; YY=$(date) && echo "$XX | $YY"
> Di 22. Aug 10:24:47 CEST 2017 | Di 22. Aug 10:26:04 CEST 2017
>
>
> Now I find that a test result like the following is worth for further
> development considerations.
>
> ?
> --- sound/usb/6fire/firmware.c
> +++ /tmp/nothing/usb/6fire/firmware.c
> @@ -246,14 +246,8 @@ static int usb6fire_fw_ezusb_upload(
>  	while (usb6fire_fw_ihex_next_record(rec)) { /* write firmware */
>  		ret = usb6fire_fw_ezusb_write(device, 0xa0, rec->address,
>  				rec->data, rec->len);
> -		if (ret < 0) {
>  			kfree(rec);
>  			release_firmware(fw);
> -			dev_err(&intf->dev,
> -				"unable to upload ezusb firmware %s: data urb.\n",
> -				fwname);
> -			return ret;
> -		}
>  	}
>
>  	release_firmware(fw);
> @@ -319,13 +313,8 @@ static int usb6fire_fw_fpga_upload(
>  			buffer[i] = bitrev8((u8)*c);
>
>  		ret = usb6fire_fw_fpga_write(device, buffer, i);
> -		if (ret < 0) {
>  			release_firmware(fw);
>  			kfree(buffer);
> -			dev_err(&intf->dev,
> -				"unable to upload fpga firmware: fw urb.\n");
> -			return ret;
> -		}
>  	}
>  	release_firmware(fw);
>  	kfree(buffer);
> ?
>
>
> How would you like to treat variations in such log messages?

They look fine as they are.

julia
