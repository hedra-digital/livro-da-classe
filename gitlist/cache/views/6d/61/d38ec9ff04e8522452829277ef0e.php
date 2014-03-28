<?php

/* rss.twig */
class __TwigTemplate_6d61d38ec9ff04e8522452829277ef0e extends Twig_Template
{
    public function __construct(Twig_Environment $env)
    {
        parent::__construct($env);

        $this->parent = false;

        $this->blocks = array(
        );
    }

    protected function doDisplay(array $context, array $blocks = array())
    {
        // line 1
        echo "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>
<rss version=\"2.0\">
    <channel>
        <title>Latest commits in ";
        // line 4
        if (isset($context["repo"])) { $_repo_ = $context["repo"]; } else { $_repo_ = null; }
        echo twig_escape_filter($this->env, $_repo_, "html", null, true);
        echo ":";
        if (isset($context["branch"])) { $_branch_ = $context["branch"]; } else { $_branch_ = null; }
        echo twig_escape_filter($this->env, $_branch_, "html", null, true);
        echo "</title>
        <description>RSS provided by GitList</description>
        <link>";
        // line 6
        echo twig_escape_filter($this->env, $this->env->getExtension('routing')->getUrl("homepage"), "html", null, true);
        echo "</link>

        ";
        // line 8
        if (isset($context["commits"])) { $_commits_ = $context["commits"]; } else { $_commits_ = null; }
        $context['_parent'] = (array) $context;
        $context['_seq'] = twig_ensure_traversable($_commits_);
        foreach ($context['_seq'] as $context["_key"] => $context["commit"]) {
            // line 9
            echo "        <item>
            <title>";
            // line 10
            if (isset($context["commit"])) { $_commit_ = $context["commit"]; } else { $_commit_ = null; }
            echo twig_escape_filter($this->env, $this->getAttribute($_commit_, "message"), "html", null, true);
            echo "</title>
            <description>";
            // line 11
            if (isset($context["commit"])) { $_commit_ = $context["commit"]; } else { $_commit_ = null; }
            echo twig_escape_filter($this->env, $this->getAttribute($this->getAttribute($_commit_, "author"), "name"), "html", null, true);
            echo " authored ";
            if (isset($context["commit"])) { $_commit_ = $context["commit"]; } else { $_commit_ = null; }
            echo twig_escape_filter($this->env, $this->getAttribute($_commit_, "shortHash"), "html", null, true);
            echo " in ";
            if (isset($context["commit"])) { $_commit_ = $context["commit"]; } else { $_commit_ = null; }
            echo twig_escape_filter($this->env, twig_date_format_filter($this->env, $this->getAttribute($_commit_, "date"), "d/m/Y \\a\\t H:i:s"), "html", null, true);
            echo "</description>
            <link>";
            // line 12
            if (isset($context["repo"])) { $_repo_ = $context["repo"]; } else { $_repo_ = null; }
            if (isset($context["commit"])) { $_commit_ = $context["commit"]; } else { $_commit_ = null; }
            echo twig_escape_filter($this->env, $this->env->getExtension('routing')->getUrl("commit", array("repo" => $_repo_, "commit" => $this->getAttribute($_commit_, "hash"))), "html", null, true);
            echo "</link>
            <pubDate>";
            // line 13
            if (isset($context["commit"])) { $_commit_ = $context["commit"]; } else { $_commit_ = null; }
            echo twig_escape_filter($this->env, twig_date_format_filter($this->env, $this->getAttribute($_commit_, "date"), "r"), "html", null, true);
            echo "</pubDate>
        </item>
        ";
        }
        $_parent = $context['_parent'];
        unset($context['_seq'], $context['_iterated'], $context['_key'], $context['commit'], $context['_parent'], $context['loop']);
        $context = array_merge($_parent, array_intersect_key($context, $_parent));
        // line 16
        echo "    </channel>
</rss>";
    }

    public function getTemplateName()
    {
        return "rss.twig";
    }

    public function isTraitable()
    {
        return false;
    }

    public function getDebugInfo()
    {
        return array (  78 => 16,  68 => 13,  62 => 12,  51 => 11,  46 => 10,  43 => 9,  38 => 8,  33 => 6,  24 => 4,  19 => 1,);
    }
}
