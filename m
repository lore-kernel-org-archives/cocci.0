From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 15 Aug 2017 22:09:11 +0200 (CEST)
Subject: [Cocci] Comparing statement lists with SmPL
In-Reply-To: <76e2fbf5-4812-18eb-2968-53019d97ab14@users.sourceforge.net>
References: <aff3ee47-e4cd-af52-1a66-304f36ddc1ed@users.sourceforge.net>
 <alpine.DEB.2.20.1708151930140.4600@hadrien>
 <69d615e4-0f62-2289-dd59-97c625ba47e8@users.sourceforge.net>
 <76e2fbf5-4812-18eb-2968-53019d97ab14@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1708152208320.2049@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 15 Aug 2017, SF Markus Elfring wrote:

> > The source code analysis results look promising by this command.
>
> I have just noticed that an other source file points details out for further
> development considerations around the mentioned functionality from the
> Coccinelle software.
>
> elfring at Sonne:~/Projekte/Linux/next-patched> git checkout next-20170803 && spatch.opt ~/Projekte/Coccinelle/janitor/show_same_statements1.cocci sound/pci/rme9652/hdspm.c
> ?
>      (ONCE) already tagged but only removed, so safe
> diff =
> ?
> @@ -6497,9 +6497,6 @@ static int snd_hdspm_create_alsa_devices
>  	i = 0;
>  	while (i < hdspm->midiPorts) {
>  		err = snd_hdspm_create_midi(card, hdspm, i);
> -		if (err < 0) {
> -			return err;
> -		}
>  		i++;
>  	}
>
> @@ -6955,10 +6952,6 @@ static int snd_hdspm_probe(struct pci_de
>  	hdspm->pci = pci;
>
>  	err = snd_hdspm_create(card, hdspm);
> -	if (err < 0) {
> -		snd_card_free(card);
> -		return err;
> -	}
>
>  	if (hdspm->io_type != MADIface) {
>  		snprintf(card->shortname, sizeof(card->shortname), "%s_%x",
> ?
>
>
> Now I am looking for a way to express the constraint that the statement list
> metavariable should match only source code with two statements at least.
> Can the search for duplicated source code be improved by the means of the
> semantic patch language?

For two statements at least you could do:

(
{
s1
s2
...
}
&
{
sl
}
)

julia
