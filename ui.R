suppressPackageStartupMessages(library(shiny))
suppressPackageStartupMessages(library(shinydashboard))
suppressPackageStartupMessages(library(shinyjs))
suppressPackageStartupMessages(library(shinydashboardPlus))
suppressPackageStartupMessages(library(MAST))
suppressPackageStartupMessages(library(bslib))
suppressPackageStartupMessages(library(shiny))
suppressPackageStartupMessages(library(GenomicRanges))

js <- '.nav-tabs-custom .nav-tabs li.active {
    border-top-color: #FFA500;
}"'
ui<-dashboardPage(

  
  skin = "yellow",
  title = "SignacShiny",
  header=dashboardHeader(
    title = shiny::tags$span("SignacShiny", style = "font-weight: bold; color: white;"), titleWidth = "240"),
  sidebar = shinydashboard::dashboardSidebar(
    # fluidRow(column(
    # 12,
    #shiny::tags$div(style = "height: 30px;"),
     # id="siderbar-container",
      #style="position:fixed;top:50;left:0;width:230px;margin:0;padding:0;line-height:1;",
      sidebarMenu(
        id = "inTabset",
        menuItem( "Home",
                  tabName = "strat",
                  icon = icon("home")),
        menuItem(
          "Quality Control",
          tabName = "one",
          icon = icon("chart-column", lib = "font-awesome")
        ),
        menuItem(
          "Cell Filtering",
          tabName = "ones",
          icon = icon("chart-column", lib = "font-awesome")
        ),
        
        menuItem(
          "Dimensionality Reduction & Clustering",
          tabName = "two",
          icon = icon("chart-column", lib = "font-awesome")
        ),
        menuItem("Differential Peaks/Genes", icon = icon("table-cells", lib = "font-awesome"), startExpanded = FALSE,
                 menuSubItem(" One vs Rest Cluster", tabName = "threeone"),
                 menuSubItem(" One vs One Cluster", tabName = "threetwo")),
        menuItem(
          "Cell Type Annotation",
          tabName="twos",
          icon=icon("chart-column", lib = "font-awesome")
        ),
        
        menuItem(
          "Genomic Region Visualization",
          tabName = "four",
          icon = icon("chart-column", lib = "font-awesome")
        ),
        menuItem(
          "GO Enrichment Analysis",
          tabName = "five",
          icon = icon("chart-column", lib = "font-awesome")
        ),
        menuItem(" Motif Analysis", icon = icon("table-cells", lib = "font-awesome"), startExpanded = FALSE,tabName= "six",
                 menuSubItem(" Motif Enrichment (One vs Rest)", tabName = "sixone"),
                 menuSubItem(" Motif Analysis (One vs One)", tabName = "sixtwo")),
        
        
        
        menuItem(
          "Transcription Factor Footprinting",
          tabName = "seven",
          icon = icon("chart-column", lib = "font-awesome")
        ),
        menuItem(
          "Help",
          tabName = "eight",
          icon = icon("glyphicon glyphicon-question-sign", lib = "glyphicon")
        ),
        menuItem(
          "About",
          tabName = "nine",
          icon = icon("glyphicon glyphicon-info-sign", lib = "glyphicon")
        ),
        fluidRow(
          column(2,div()),
          column(6,tags$div(class = "custom-box", valueBoxOutput("vbox_cell_tab1", width = NULL)))),
        fluidRow(
          column(2,div()),
          column(6,tags$div(class = "custom-box", valueBoxOutput("vbox_cell_tab2", width = NULL))))
        # column(5,div(valueBoxOutput("vbox_cell_tab1",width = 12))),
        # column(7,div(valueBoxOutput("vbox_cell_tab2",width = 12)))
      ),
    width="240px",
    shiny::tags$head(shiny::tags$style(
      HTML(
        "
      .skin-blue .main-sidebar .sidebar-menu > li > a[data-value='home'] {
            font-size: 14px
      }  
      .skin-yellow .main-sidebar .sidebar-menu > li > a[data-value='one'] {
      color: #808080; /* 灰色 */; font-size: 14px
      }
      .skin-yellow .main-sidebar .sidebar-menu > li > a[data-value='ones'] {
      color: 	#808080; /* 灰色 */; font-size: 14px
      }
      .skin-yellow .main-sidebar .sidebar-menu > li > a[data-value='two'] {
      color: 	#808080; /* 灰色 */; font-size: 14px
      }
      .skin-yellow .main-sidebar .sidebar-menu > li > a[data-value='twos'] {
      color: 	#808080; /* 灰色 */; font-size: 14px
      }
      .skin-yellow .main-sidebar .sidebar-menu > li > a[data-value='threeone'] {
      color: 	#808080; /* 灰色 */; font-size: 14px
      }
      .skin-yellow .main-sidebar .sidebar-menu > li > a[data-value='threetwo'] {
      color: 	#808080; /* 灰色 */; font-size: 14px
      }
      .skin-yellow .main-sidebar .sidebar-menu > li > a[data-value='four'] {
      color: 	#808080; /* 灰色 */; font-size: 14px
      }
      .skin-yellow .main-sidebar .sidebar-menu > li > a[data-value='five'] {
      color: 	#808080; /* 灰色 */; font-size: 14px
      }
      .skin-yellow .main-sidebar .sidebar-menu > li > a[data-value='sixone'] {
      color: 	#808080; /* 灰色 */; font-size: 14px
      }
      .skin-yellow .main-sidebar .sidebar-menu > li > a[data-value='sixtwo'] {
      color: 	#808080; /* 灰色 */; font-size: 14px
      }
      .skin-yellow .main-sidebar .sidebar-menu > li > a[data-value='five'] {
      color: 	#808080; /* 灰色 */; font-size: 14px
      }
      .skin-yellow .main-sidebar .sidebar-menu > li > a[data-value='seven'] {
      color: 	#808080; /* 灰色 */; font-size: 14px
      }
      .skin-yellow .main-sidebar .sidebar .sidebar-menu .active a{
            background-color: #434C5E;
            font-size: 14px
    }

       .sidebar {
        position: fixed;
        top: 50px;
        bottom: 0;
        width:240px;
      }

      /*固定标题*/
        .skin-yellow .main-header .logo{
            position: fixed;
            height: 50px;
            width: 240px;
        }
        .skin-yellow .navbar-static-top {
          position: fixed;
          width: 100%;
        }
             " 
        )
    ))),
  body=dashboardBody(
    shiny::tags$div(style = "height: 50px;"),
    useShinyjs(),
    div(
      id="content-container",
      class="content-wrapper",
      style="width:auto;margin:0;padding:0;line-height:1;",
      useShinyjs(),
      tags$style(js),
      tags$head(
        tags$style(
          HTML(" .my-custom-div { text-align: justify;font-size: 16.5px;color:black;
                                font-style:calibri;
                                word-spacing:2;
                                line-height:1.5;
                                baseline：middle;
                               }
               .small-box {height:85px;width:90px}
               .custom-box {
                           height: 85px
                           justify-content: center; /* 水平居中 */
                           width: 140px !important;
                           background-color:  #F39C12 !important;     
                           text-align:center; /* Optional: center text inside the box */
                            }
               .small-box.bg-orange { background-color: #ffc916 !important;  }"))),
      tabItems(
        tabItem(
          tabName = "strat",
          fluidRow(
            shinydashboard::box(
              title = tagList(icon("readme"),"Introduction"),
              width =12, 
              solidHeader = T, 
              status = "warning", 
              collapsible = TRUE,
              helpText(
                div(class="my-custom-div",
                "SignacShiny is an interactive R Shiny application for downstream analysis of processed scATAC-seq data. Built on Signac and Seurat, it provides quality control, cell filtering, dimensionality reduction, clustering, differential accessibility and gene activity analysis, cell annotation, genomic region visualization, GO enrichment, motif analysis, and transcription factor footprinting in a graphical workflow. Users can adjust parameters and inspect results without writing R code. Alignment and initial peak calling are completed before import."
                    # style = "font-size:17.5px;font-style:calibri;color:black;",
                    # align = "justify"
                )
              )
            )),
          fluidRow(
            column(4,
                   shinydashboard::box(
                     
                     title = tagList(icon("gears"),"Inputdata"), width =NULL, status = "warning", collapsible = TRUE,
                     
                     tags$head(
                       tags$style(HTML("
                                      .popover {
                                        max-width: 450px; /* 设置弹出提示框的最大宽度 */} "))
                     ),
                     
                     selectInput("Selectdata", label = ("Data Source："), choices = list("Example Data","Custom Data"),selected = "Example Data"),
                     selectInput("SelectRefer_data", label = "Reference Dataset:", choices = list("EnsDb.Hsapiens.v75","EnsDb.Hsapiens.v86","EnsDb.Mmusculus.v79"),selected = "EnsDb.Hsapiens.v75"),
                     uiOutput("FileInputs"),
                     br(),
                     div(actionButton("submit_Start","Start", icon = icon("play-circle")), align = "center")
                     
                   )),
            column(8,
                   shinydashboard::box(
                     title = tagList(icon("gears"),"Workflow"), width =NULL, solidHeader = F, status = "warning", collapsible = TRUE,
                     align = "center",
                     shiny::tags$a(href = "workflow.svg", target = "_blank", shiny::tags$img(src = "workflow.svg", style = "max-width: 100%; height: auto; display: block;"))
                   )))),
        
        tabItem(
          tabName = "one",
          fluidRow(
            column(12,
              column(11,fluidRow(
                   column(1,valueBoxOutput("vbox_load_tab1",width=NULL)),
                   column(1,valueBoxOutput("vbox_qc_tab1",width=NULL)),
                   column(1,valueBoxOutput("vbox_filter_cell_tab1",width=NULL)),
                   column(1,valueBoxOutput("vbox_NDR_tab1",width=NULL)),
                   column(1,valueBoxOutput("vbox_geneactivity_tab1",width = NULL)),
                   column(1,valueBoxOutput("vbox_findAllmaker_tab1",width=NULL)),
                   column(1,valueBoxOutput("vbox_findIdentsmaker_tab1",width=NULL)),
                   column(1,valueBoxOutput("vbox_annotation_tab1",width =NULL)),
                   column(1,valueBoxOutput("vbox_calling_peak_tab1",width = NULL)),
                   column(1,valueBoxOutput("vbox_GO_plot_tab1",width = NULL)),
                   column(1,valueBoxOutput("vbox_motifs_analysis_tab1",width = NULL)),
                   column(1,valueBoxOutput("vbox_motifs_ident_analysis_tab1",width = NULL))
                   
                 )),
              column(1,fluidRow(column(1,valueBoxOutput("vbox_footprint_tab1",width = NULL))))
          )
          ),
          fluidRow(
            shinydashboard::box(
              title = tagList(icon("readme"),"Introduction"), width =12, solidHeader = T, status = "warning", collapsible = TRUE,
              helpText(div(class="my-custom-div",
              "After processed data are imported, the Quality Control module calculates fragment counts per cell, transcription start site (TSS) enrichment, nucleosome signal, fraction of reads in peaks, and blacklist region ratio. It summarizes data quality using a density scatter plot, a TSS enrichment profile, and a nucleosome banding plot. These views allow users to inspect the calculated metrics before setting cell-filtering thresholds in the next module."
                           
              )),
              div(actionButton("submit_Qualitycontrol","Quality Control", icon = icon("play-circle")), align = "center")
              )),
          
          fluidRow(
            column(6,
                   
                   shinydashboard::box(
                     title = tagList(icon("chart-column"),"DensityScatter"), width =NULL,status = "warning", collapsible = TRUE,
                     plotOutput("QCDSPlot",width="100%")%>%withSpinner(),
                     splitLayout(cellWidths = c("30%","30%","40%"),
                                 numericInput("DensityScatter_PlotWidth", "Width", min = 0, max = 250,value = 10),
                                 numericInput("DensityScatter_PlotHeight", "Height", min = 0, max = 250, value = 7),
                                 selectizeInput('DensityScatter_PlotChoices',label = "Format",choices = c(".pdf",".png",".tiff"),selected = ".png"),
                                 tags$head(tags$style(HTML(".shiny-split-layout > div { overflow: visible;}")))),
                     div(downloadButton(outputId = "DensityScatter_download_plot", label = "Download"), align = "center")
                   )),
            column(6,
                   shinydashboard::tabBox(width =NULL,
                     tabPanel(
                       title = tagList(icon("chart-column"),"TssPlot"), width =NULL,
                       # sliderInput(inputId = "tss", label = ("TSS Enrichment"), min = 0, max = 10, value = 2),
                       plotOutput("QCtssPlot",width="100%")%>%withSpinner(),
                       splitLayout(cellWidths = c("30%","30%","40%"),
                                   numericInput("TSSPlot_PlotWidth", "Width", min = 0, max = 250, value = 10),
                                   numericInput("TSSPlot_PlotHeight", "Height", min = 0, max = 250, value = 7),
                                   selectizeInput('TSSPlot_PlotChoices',label = "Format",choices = c(".pdf",".png",".tiff"),selected = ".png"),
                                   tags$head(tags$style(HTML(".shiny-split-layout > div { overflow: visible;}")))),
                       div(downloadButton(outputId = "TSSPlot_download_plot", label = "Download"), align = "center")
                     ),
                     tabPanel(
                       title = tagList(icon("chart-column"),"FragmentPlot"), width =NULL, 
                       # sliderInput(inputId = "fragment", label = ("Fragment Length"), min = 0, max = 10, value = 4),
                       plotOutput("QCFragmentPlot",width="100%")%>%withSpinner(),
                       splitLayout(cellWidths = c("30%","30%","40%"),
                                   numericInput("FragmentPlot_PlotWidth", "Width", min = 0, max = 250, value = 10),
                                   numericInput("FragmentPlot_PlotHeight", "Height", min = 0, max = 250, value = 7),
                                   selectizeInput('FragmentPlot_PlotChoices',label = "Format",choices = c(".pdf",".png",".tiff"),selected = ".png"),
                                   tags$head(tags$style(HTML(".shiny-split-layout > div { overflow: visible;}")))
                       ),
                       div(downloadButton(outputId = "FragmentPlot_download_plot", label = "Download"), align = "center")
                     )
                   )
            )
          )),
        tabItem(
          tabName = "ones",
          fluidRow(
            column(12,
                   column(11,fluidRow(
                     column(1,valueBoxOutput("vbox_load_tab2",width=NULL)),
                     column(1,valueBoxOutput("vbox_qc_tab2",width=NULL)),
                     column(1,valueBoxOutput("vbox_filter_cell_tab2",width=NULL)),
                     column(1,valueBoxOutput("vbox_NDR_tab2",width=NULL)),
                     column(1,valueBoxOutput("vbox_geneactivity_tab2",width = NULL)),
                     column(1,valueBoxOutput("vbox_findAllmaker_tab2",width=NULL)),
                     column(1,valueBoxOutput("vbox_findIdentsmaker_tab2",width=NULL)),
                     column(1,valueBoxOutput("vbox_annotation_tab2",width = NULL)),
                     column(1,valueBoxOutput("vbox_calling_peak_tab2",width = NULL)),
                     column(1,valueBoxOutput("vbox_GO_plot_tab2",width = NULL)),
                     column(1,valueBoxOutput("vbox_motifs_analysis_tab2",width = NULL)),
                     column(1,valueBoxOutput("vbox_motifs_ident_analysis_tab2",width = NULL))
                     
                   )),
                   column(1,fluidRow(column(1,valueBoxOutput("vbox_footprint_tab2",width = NULL))))
            )
          ),
          fluidRow(
            shinydashboard::box(
              title = tagList(icon("readme"),"Introduction"), width =12, solidHeader = T, status = "warning", collapsible = TRUE,
              helpText(div(class="my-custom-div",
                           "The Cell Filtering module displays the calculated quality-control metrics as interactive violin plots. Users can set thresholds for fragment counts, TSS enrichment, nucleosome signal, blacklist region ratio, and fraction of reads in peaks. Before applying the filters, they can inspect the resulting cell-retention statistics. Cells that meet the selected criteria are retained for dimensionality reduction and subsequent analyses."
                           # style = "font-size:17.5px;font-style:calibri;color:black;",
                           # align = "justify"
              )))
          ),
          fluidRow(
            column(width = 3,
                   shinydashboard::box(
                     title = tagList(icon("gears"),"Filter"), width =NULL, status = "warning", collapsible = TRUE,
                     # div(actionButton("submit31","QC and visualize", icon = icon("play-circle")), align = "center"),
                     numericInput(inputId = "qcfragmentmin", label = "Min Peak Fragments :", value = 2000),
                     numericInput(inputId = "qcfragmentmax", label = "Max Peak Fragments :", value = 30000),
                     numericInput(inputId = "qctssmin", label = "Min TSS Enrichment :", value = 2),
                     numericInput(inputId = "qcratiomax", label = "Max Blacklist Ratio :", value = 0.05),
                     numericInput(inputId = "qcsignalmax", label = "Max Nucleosome Signal :", value = 4),
                     numericInput(inputId = "qcpeaksmin", label = "Min Percentage of Reads in Peaks:", value = 15),
                     div(actionButton("submit_FilterCells","Cell Filtering", icon = icon("play-circle")), align = "center")
                   )
                   # infoBox("pbmc1")
            ),
            column(width = 9,
                   tags$head(tags$style(type = "text/css", HTML(".shiny-text-output {font-size:18px; }"))), 
                   shinydashboard::tabBox(
                     title = tagList(icon("chart-column"),"VinPlot"), width =NULL,selected = "before filte",side="right",
                     # useShinyjs(), 
                     tabsetPanel(id="qVinplot",
                                 tabPanel("Before Filter",
                                          plotOutput("QCVlnPlot",width="100%")%>%withSpinner(),
                                          div(id='custom-text-output',textOutput(outputId="text.cellsremain1")),
                                          br(),
                                          splitLayout(cellWidths = c("30%","30%","40%"),
                                                      numericInput("QCVlnPlot_PlotWidth", "Width", min = 0, max = 250, value = 10),
                                                      numericInput("QCVlnPlot_PlotHeight", "Height", min = 0, max = 250, value = 7),
                                                      selectizeInput('QCVlnPlot_PlotChoices',label = "Format",choices = c(".pdf",".png",".tiff"),selected = ".png"),
                                                      tags$head(tags$style(HTML(".shiny-split-layout > div { overflow: visible;}")))),
                                          div(downloadButton(outputId = "QCVlnPlot_download_plot", label = "Download"), align = "center")),                   
                                 tabPanel("After Filter",
                                          plotOutput("QCVlnPlots",width="100%")%>%withSpinner(),
                                          div(id='custom-text-output',textOutput(outputId="text.cellsremain2")),
                                          br(),
                                          splitLayout(cellWidths = c("30%","30%","40%"),
                                                      numericInput("QCVlnPlots_PlotWidth", "Width", min = 0, max = 250, value = 10),
                                                      numericInput("QCVlnPlots_PlotHeight", "Height", min = 0, max = 250, value = 7),
                                                      selectizeInput('QCVlnPlots_PlotChoices',label = "Format",choices = c(".pdf",".png",".tiff"),selected = ".png"),
                                                      tags$head(tags$style(HTML(".shiny-split-layout > div { overflow: visible;}")))),
                                          div(downloadButton(outputId = "QCVlnPlots_download_plot", label = "Download"), align = "center")))
                     )
            ))),
        tabItem(
          tabName = "two",
          fluidRow(
            column(12,
                   column(11,fluidRow(
                     column(1,valueBoxOutput("vbox_load_tab3",width=NULL)),
                     column(1,valueBoxOutput("vbox_qc_tab3",width=NULL)),
                     column(1,valueBoxOutput("vbox_filter_cell_tab3",width=NULL)),
                     column(1,valueBoxOutput("vbox_NDR_tab3",width=NULL)),
                     column(1,valueBoxOutput("vbox_geneactivity_tab3",width = NULL)),
                     column(1,valueBoxOutput("vbox_findAllmaker_tab3",width=NULL)),
                     column(1,valueBoxOutput("vbox_findIdentsmaker_tab3",width=NULL)),
                     column(1,valueBoxOutput("vbox_annotation_tab3",width = NULL)),
                     column(1,valueBoxOutput("vbox_calling_peak_tab3",width = NULL)),
                     column(1,valueBoxOutput("vbox_GO_plot_tab3",width = NULL)),
                     column(1,valueBoxOutput("vbox_motifs_analysis_tab3",width = NULL)),
                     column(1,valueBoxOutput("vbox_motifs_ident_analysis_tab3",width = NULL))
                   )),
                   column(1,fluidRow( column(1,valueBoxOutput("vbox_footprint_tab3",width = NULL))))
            )
           
          ),
          fluidRow(
                   shinydashboard::box(
                     title = tagList(icon("readme"),"Introduction"), width =12,  solidHeader = T, status = "warning", collapsible = TRUE,
                     helpText(div(class="my-custom-div",
                                  "SignacShiny applies term frequency-inverse document frequency (TF-IDF) normalization followed by singular value decomposition (SVD) to obtain latent semantic indexing (LSI) components. A depth-correlation plot helps users select dimensions for downstream analysis. Selected components are used for UMAP or t-SNE visualization and graph-based clustering. Users can adjust the dimensions and clustering resolution through the interface. The module also calculates a gene activity matrix from accessibility signals associated with gene bodies and promoters for annotation and gene-level analyses."
                                  # style = "font-size:17.5px;font-style:calibri;color:black;",
                                  # align = "justify"
                     )))),
          fluidRow(
            shinydashboard::box(
              title = tagList(icon("gears"),"Parameter Setting",
                              bsButton('q1',label = '',icon = icon(name = 'question'),size = 'extra-small'),
                              bsPopover(id = 'q1',title=NULL,
                              content ='You need to run according to the steps:Normalization Linear Dimensional Reduction→None Linear Dimensional Reduction→Clustering→Gene Activity Matrix',
                              placement = 'right',trigger = 'hover',options = list(container = 'body'))),
                      width =12,status = "warning", collapsible = TRUE,
             
              fluidRow(
              column(4,
                     div(actionButton("submit_Normalization",HTML(" Normalization "), icon = icon("play-circle")), align = "center"),
                     br(),
                     sliderInput(inputId = "min.cutoff", label = ("Variable Peaks Cutoff:"), pre = "q",min = 0, max = 99, value=5),
                     useShinyjs(),
                     uiOutput("text.featuresremain"),
                     br(),
                     div(actionButton("submit_LDR",HTML("Linear Dimensional Reduction"), icon = icon("play-circle")), align = "center")
                    
                     ),
              column(4,
                     useSweetAlert(),
                     sliderInput(inputId = "umapdim", label = ("UMAP/T-SNE Dims:"), min = 0, max = 50,value = c(2,15)),
                     radioButtons('reduction_method',label = "None Lnear Dimension Reduction Method：",choices = c("UMAP","T-SNE"),selected = "UMAP",inline = TRUE),
                     div(actionButton("submit_NLDR",HTML("None Linear Dimensional Reduction "), icon = icon("play-circle")),align="center") 
                     # fluidRow(
                     #   column(6,radioButtons('reduction_method',label = "None Lnear Dimension Reduction Method：",choices = c("UMAP","T-SNE"),selected = "UMAP",inline = TRUE)),
                     #   column(6,div(actionButton("submit_NLDR",HTML("None Linear <br>Dimensional Reduction "), icon = icon("play-circle")),align="center") )
                     # )
                     ),
              column(4,
                     sliderInput(inputId = "resolution", label = ("Resolution:"), min = 0, max = 2, value = 0.8,step = 0.1),
                     fluidRow(
                       column(7, radioButtons("clusteralgorithm", label = "Clusteralgorithm:", choices = list("SLM Algorithm"= "3","Original Louvain"= "1","Louvain Algorithm with Multilevel Refinement"= "2"),selected = "3",inline =F)),
                       column(5,
                              div(actionButton("submit_Clustering","Clustering", icon = icon("play-circle")),align="right" )
                             ))
                     
                     )
              )
          )),
          fluidRow(
            shinydashboard::box(
                title = tagList(icon("chart-column"),"Create Gene Activity Matrix "), width =12, status = "warning", collapsible = TRUE,
                helpText(
                  div(class="my-custom-div",
                      strong("Greate Gene Activity Matrix"), 
                      "module in our single-cell ATAC-seq platform enables the ",
                      strong("quantification of gene activity based on chromatin accessibility"),
                      ".Since scATAC-seq primarily captures open chromatin regions rather than direct gene expression levels, interpreting and annotating clusters can be more challenging 
                      than in scRNA-seq. This module helps ",
                      strong("bridge that gap by estimating gene activity from chromatin accessibility data, allowing users to better interpret single-cell 
                      ATAC-seq results."),
                      " By associating chromatin accessibility with potential gene expression, this module facilitates a deeper understanding of cell-type-specific regulatory 
                      landscapes, providing valuable insights into gene regulation and cellular function.", style = "font-size:15.5px;",align="center")
                 
                  ),
                div(actionButton("submit_GeneActivity","Create Gene Activity Matrix", icon = icon("play-circle")),align="center" ))
          ),
          fluidRow(
                    shinydashboard::box(
                     title = tagList(icon("chart-column"),"DepthCorPlot"), width = 6, status = "warning", collapsible = TRUE,
                     plotlyOutput("DepthCorPlot",width="90%")%>%withSpinner(),
                     splitLayout(cellWidths = c("30%","30%","40%"),
                                 numericInput("DepthCorPlot_PlotWidth", "Width", min = 0, max = 250, value = 10),
                                 numericInput("DepthCorPlot_PlotHeight", "Height", min = 0, max = 250, value = 7),
                                 selectizeInput('DepthCorPlot_PlotChoices',label = "Format",choices = c(".pdf",".png",".tiff"),selected = ".png"),
                                 tags$head(tags$style(HTML(".shiny-split-layout > div { overflow: visible;}")))
                     ),
                     div(downloadButton(outputId = "DepthCorPlot_download_plot", label = "Download"), align = "center")),
            
                   shinydashboard::box(
                     title = tagList(icon("chart-column"),"ClusterDimPlot"), width =6,status = "warning", collapsible = TRUE,
                     plotOutput("ClusterDimPlot",width="100%")%>%withSpinner(),
                     splitLayout(cellWidths = c("30%","30%","40%"),
                                 numericInput("ClusterDimPlot_PlotWidth", "Width", min = 0, max = 250, value = 10),
                                 numericInput("ClusterDimPlot_PlotHeight", "Height", min = 0, max = 250, value = 7),
                                 selectizeInput('ClusterDimPlot_PlotChoices',label = "Format",choices = c(".pdf",".png",".tiff"),selected = ".png"),
                                 tags$head(tags$style(HTML(".shiny-split-layout > div { overflow: visible;}")))
                     ),
                     div(downloadButton(outputId = "ClusterDimPlot_download_plot", label = "Download"), align = "center")))
        ),
        tabItem(
          tabName = "twos",
          fluidRow(
            column(12,
                   column(11,fluidRow(
                     column(1,valueBoxOutput("vbox_load_tab4",width=NULL)),
                     column(1,valueBoxOutput("vbox_qc_tab4",width=NULL)),
                     column(1,valueBoxOutput("vbox_filter_cell_tab4",width=NULL)),
                     column(1,valueBoxOutput("vbox_NDR_tab4",width=NULL)),
                     column(1,valueBoxOutput("vbox_geneactivity_tab4",width = NULL)),
                     column(1,valueBoxOutput("vbox_findAllmaker_tab4",width=NULL)),
                     column(1,valueBoxOutput("vbox_findIdentsmaker_tab4",width=NULL)),
                     column(1,valueBoxOutput("vbox_annotation_tab4",width = NULL)),
                     column(1,valueBoxOutput("vbox_calling_peak_tab4",width = NULL)),
                     column(1,valueBoxOutput("vbox_GO_plot_tab4",width = NULL)),
                     column(1,valueBoxOutput("vbox_motifs_analysis_tab4",width = NULL)),
                     column(1,valueBoxOutput("vbox_motifs_ident_analysis_tab4",width = NULL))
                     )),
                   column(1,fluidRow(column(1,valueBoxOutput("vbox_footprint_tab4",width = NULL))))
            )
           
          ),
          
          fluidRow(
            column(6,
                   shinydashboard::box(
                     title = tagList(icon("readme"),"Introduction"), width = NULL,height = 235, solidHeader = T, status = "warning", collapsible = TRUE,
                     helpText(div(class="my-custom-div",
                                  "SignacShiny uses SingleR to compare scATAC-seq-derived gene activity profiles with a selected transcriptomic reference. The module provides human and mouse reference datasets and returns predicted cell identities with annotation scores. Users can inspect these scores in a table and display predicted labels on a UMAP or t-SNE embedding. The labels provide a preliminary annotation that can be evaluated alongside cluster markers and the chosen reference."
                                  # style = "font-size:17.5px;font-style:calibri;color:black;",
                                  # align = "justify"
                     )
                     ))),
            column(6,
                   shinydashboard::box(
                     title = tagList(icon("gears"),"Parameter Setting"), width =NULL,height = 235,status = "warning", collapsible = TRUE,
                     div(selectizeInput("reference_type",label="Species Type:",choices=c("Human","Mouse"),selected="Human")),
                     div(uiOutput("Reference_select")),
                     div(actionButton("submit_singleR","Cell Type Annotation", icon = icon("play-circle")), align = "center")))
          ),
          fluidRow(
            column(6,
                   shinydashboard::box(
                     title = tagList(icon("table-cells"),"SingleR Table"), width =NULL,status = "warning",height = "460px", collapsible = TRUE,
                     DT::dataTableOutput("singleR_data"),
                     div(downloadButton(outputId = "annotation_download_data", label = "Download"), align = "center"))),
            column(6,
                   shinydashboard::box(
                     title = tagList(icon("chart-column"),"DimPlot"), width =NULL,height = "460px", status = "warning", collapsible = TRUE,
                     plotOutput("DimPlot",height = "300")%>%withSpinner(),
                     splitLayout(cellWidths = c("30%","30%","40%"),
                                 numericInput("annotation_PlotWidth", "Width", min = 0, max = 250, value = 10),
                                 numericInput("annotation_PlotHeight", "Height", min = 0, max = 250, value = 7),
                                 selectizeInput("annotation_PlotChoices",label = "Format",choices = c(".pdf",".png",".tiff"),selected = ".pdf"),
                                 tags$head(tags$style(HTML(".shiny-split-layout > div { overflow: visible;}")))
                     ),
                     div(downloadButton(outputId = "annotation_download_plot", label = "Download"), align = "center"))))),
        tabItem(
          tabName = "threeone",
          fluidRow(
            column(12,
                   column(11,fluidRow(
                     column(1,valueBoxOutput("vbox_load_tab5",width=NULL)),
                     column(1,valueBoxOutput("vbox_qc_tab5",width=NULL)),
                     column(1,valueBoxOutput("vbox_filter_cell_tab5",width=NULL)),
                     column(1,valueBoxOutput("vbox_NDR_tab5",width=NULL)),
                     column(1,valueBoxOutput("vbox_geneactivity_tab5",width = NULL)),
                     column(1,valueBoxOutput("vbox_findAllmaker_tab5",width=NULL)),
                     column(1,valueBoxOutput("vbox_findIdentsmaker_tab5",width=NULL)),
                     column(1,valueBoxOutput("vbox_annotation_tab5",width = NULL)),
                     column(1,valueBoxOutput("vbox_calling_peak_tab5",width = NULL)),
                     column(1,valueBoxOutput("vbox_GO_plot_tab5",width = NULL)),
                     column(1,valueBoxOutput("vbox_motifs_analysis_tab5",width = NULL)),
                     column(1,valueBoxOutput("vbox_motifs_ident_analysis_tab5",width = NULL))
                     
                   )),
                   column(1,fluidRow(column(1,valueBoxOutput("vbox_footprint_tab5",width = NULL))))
            )
            
            
          ),
          fluidRow(
            column(6,shinydashboard::box(title = tagList(icon("readme"),"Introduction"), width = NULL,height = 280,solidHeader = T, status = "warning", collapsible = TRUE,
                                         helpText(div(class="my-custom-div",
                                                      "The One vs Rest module compares a selected cluster with all remaining cells to identify differentially accessible peaks or differences in gene activity scores. Users can select a supported statistical test and set a minimum detection frequency and fold-change threshold. The results table reports effect sizes, adjusted P-values, and detection fractions. Selected features can be examined in feature-level plots."
                                                      # style = "font-size:17.5px;font-style:calibri;color:black;",
                                                      # align = "justify"
                                         )))),
            column(6,
                   shinydashboard::box(
                     title = tagList(icon("gears"),"Parameter Setting"), width =NULL,height=280,status = "warning", collapsible = TRUE,
                     fluidRow(
                       column(4,radioButtons("AssayRadio1", label = "Assay:", choices = list("peaks"),selected = "peaks", inline = TRUE)),
                       column(8,radioButtons("TestUse1", label = "Method:", choices = list("Wilcox"="wilcox","MAST"="MAST","LR"="LR","Bimod"="bimod","Roc"="roc"), selected = "LR",inline = TRUE),
                              radioButtons("OnlyPos1", label = "Only.Pos:", choices = list("True"="True","False"="False"), selected = "False",inline = TRUE))
                     ),
                     splitLayout(cellwidths=c("50%","50%"),
                       numericInput(inputId = "LogfcThreshold1", label = "Logfc.threshold:", value = 0.25),
                       numericInput(inputId = "MinPct1", label = "Min.pct:", value = 0.7)
                     ),
                     bsPopover(id = 'MinPct1',title=NULL,
                               content ='only test genes that are detected in a minimum fraction of min.pct cells in either of the two populations.Meant to speed up the function by not testing genes that are very infrequently expressed. Default is 0.7',
                               placement = 'bottom',trigger = 'hover',options = list(container = 'body')),
                     bsPopover(id = 'LogfcThreshold1',title=NULL,
                               content =' Increasing logfc.threshold speeds up the function, but can miss weaker signals.Default is 0.25 ',
                               placement = 'bottom',trigger = 'hover',options = list(container = 'body')),
                     div(actionButton("submit_FindAllMarkers","Find All Markers", icon = icon("play-circle")), align = "center")
                   ))),
          fluidRow(
            # column(6,
                   shinydashboard::box(
                     title = tagList(icon("table-cells"),"Find All Markers"), width =12, status = "warning", collapsible = TRUE,
                     splitLayout(cellWidths = c("30%","30%","40%"),
                                 selectInput("Ident13", label = "Select Cluster:", choices = list("All"="All"),selected="All"),
                                 numericInput(inputId = "P_val_1", label = "pvalueCutoff:",step=0.1, value = 0.05),
                                 numericInput(inputId = "pct_1", label = "Min.pct:", step=0.1,value = 0.7)
                                 
                     ),
                     DT::dataTableOutput("FindAllMarkers_data")%>%withSpinner(),
                     div(downloadButton("FindAllMarkers_download_data", "Download"), align = "center"))
                   # ),
            # column(6,
            #        shinydashboard::box(
            #          title = tagList(icon("table-cells"),"Cluster Markers"), width =NULL,height=555, status = "warning", collapsible = TRUE,
            #          helpText(
            #            div("Please proceed to the cluster Markers module on the left first and Choose one of the clusters you want to learn about"),
            #          ),
            #          # selectInput("Ident13", label = "Cluster:", choices = list("NULL"="NULL"),selected="NULL"),
            #          uiOutput("submit_ClusterMarkers"),
            #         DT::dataTableOutput("ClusterMarkers_data"),
            #          br(),
            #          div(downloadButton("ClusterMarkers_download_data", "Download"), align = "center")))
            ),
          hidden(
          fluidRow(
              id = "featurePlotBox",
              shinydashboard::box(
                title = tagList(icon("chart-column"),"FeaturePlot"), width =12,status = "warning", collapsible = TRUE,
                selectizeInput(inputId = "FeaturePlot_gene_select", label = "Marker Name:", choices = list("NULL"="NULL"),selected="NULL",
                               multiple = T,options = NULL),
                div(actionButton("submit_FeaturePlot","FeaturePlot", icon = icon("play-circle")), align = "center"),
                plotOutput("FeaturePlot")%>%withSpinner(),
                splitLayout(cellWidths = c("30%","30%","40%"),
                            numericInput("FeaturePlot_PlotWidth", "Width", min = 0, max = 250, value = 10),
                            numericInput("FeaturePlot_PlotHeight", "Height", min = 0, max = 250, value = 7),
                            selectizeInput('FeaturePlot_PlotChoices',label = "Format",choices = c(".pdf",".png",".tiff"),selected = ".png"),
                            tags$head(tags$style(HTML(".shiny-split-layout > div { overflow: visible;}")))),
                div(downloadButton(outputId = "FeaturePlot_download_plot", label = "Download"), align = "center")
              )
          )
        )),
        tabItem(
          tabName = "threetwo",
          fluidRow(
            column(12,
                   column(11,fluidRow(
                     column(1,valueBoxOutput("vbox_load_tab6",width=NULL)),
                     column(1,valueBoxOutput("vbox_qc_tab6",width=NULL)),
                     column(1,valueBoxOutput("vbox_filter_cell_tab6",width=NULL)),
                     column(1,valueBoxOutput("vbox_NDR_tab6",width=NULL)),
                     column(1,valueBoxOutput("vbox_geneactivity_tab6",width = NULL)),
                     column(1,valueBoxOutput("vbox_findAllmaker_tab6",width=NULL)),
                     column(1,valueBoxOutput("vbox_findIdentsmaker_tab6",width=NULL)),
                     column(1,valueBoxOutput("vbox_annotation_tab6",width = NULL)),
                     column(1,valueBoxOutput("vbox_calling_peak_tab6",width = NULL)),
                     column(1,valueBoxOutput("vbox_GO_plot_tab6",width = NULL)),
                     column(1,valueBoxOutput("vbox_motifs_analysis_tab6",width = NULL)),
                     column(1,valueBoxOutput("vbox_motifs_ident_analysis_tab6",width = NULL))
                     
                   )),
                   column(1,fluidRow(column(1,valueBoxOutput("vbox_footprint_tab6",width = NULL))))
            )
           
          ),
          fluidRow(
            column(6,
                   shinydashboard::box(title = tagList(icon("readme"),"Introduction"), width = NULL, height=330,solidHeader = T, status = "warning", collapsible = TRUE,
                                       helpText(div(class="my-custom-div",
                                                    "The One vs One module compares two user-selected clusters for differential accessibility or differences in gene activity scores. Users can choose a supported statistical test and specify minimum detection frequency and fold-change thresholds. The results table presents effect sizes, adjusted P-values, and detection fractions. Selected peaks or gene activity features can then be inspected in violin or feature plots, depending on the assay used."
                                                    # style = "font-size:17.5px;font-style:calibri;color:black;",
                                                    # align = "justify"
                                       )))),
            column(6,
                   shinydashboard::box(
                     title = tagList(icon("gears"),"Parameter Setting"), width = NULL, height=330,status = "warning", collapsible = TRUE,
                     fluidRow(
                       column(4,radioButtons("AssayRadio2", label = ("Assay:"), choices =list("peaks"),selected = "peaks")),
                       column(8,radioButtons("TestUse2", label = "Method:", choices = list("wilcox"="wilcox","MAST"="MAST","LR"="LR","bimod"="bimod","roc"="roc"), selected = "LR",inline = TRUE),
                              radioButtons("OnlyPos2", label = "Only.pos:", choices = list("True"="True","False"="False"), selected = "False",inline = TRUE))),
                     splitLayout(cellwidths=c("50%","50%"),
                                 numericInput(inputId = "LogfcThreshold2", label = "Logfc.threshold:", step=0.1,value = 0.25),
                                 numericInput(inputId = "MinPct2", label = "Min.pct:",step=0.1, value = 0.7)),
                     splitLayout(cellwidths=c("50%","50%"),
                                 selectInput("Ident11", label = "Ident.1:", choices = list("NULL"="NULL"),selected="NULL"),
                                 selectInput("Ident12", label = "Ident.2:", choices = list("NULL"="NULL"),selected="NULL")),
                                 bsPopover(id = 'LogfcThreshold2',title=NULL,
                                           content =' Increasing logfc.threshold speeds up the function, but can miss weaker signals.Default is 0.25 ',
                                           placement = 'bottom',trigger = 'hover',options = list(container = 'body')),
                                 bsPopover(id = 'MinPct2',title=NULL,
                                           content ='only test genes that are detected in a minimum fraction of min.pct cells in either of the two populations.Meant to speed up the function by not testing genes that are very infrequently expressed. Default is 0.7',
                                           placement = 'bottom',trigger = 'hover'),
                     div(actionButton("submit_FindMarkers","Find Idents Markers", icon = icon("play-circle")), align = "center")
                   ))),
          fluidRow(
            shinydashboard::box(
              title = tagList(icon("table-cells"),"Compare Markers"), width =12,  status = "warning", collapsible = TRUE,
              DT::dataTableOutput("CompareMarkers_data")%>%withSpinner(),
              br(),
              div(downloadButton("CompareMarkers_download_data", "Download"), align = "center"))
          ),
          fluidRow(
            shinydashboard::box(
              title = tagList(icon("table-cells"),"VinPlot"), width =6,  status = "warning", collapsible = TRUE,
              plotOutput('FM_VinPlot')%>%withSpinner(),
              splitLayout(cellWidths = c("30%","30%","40%"),
                          numericInput("FM_VinPlot_PlotWidth", "Width", min = 0, max = 250, value = 10),
                          numericInput("FM_VinPlot_PlotHeight", "Height", min = 0, max = 250, value = 13),
                          selectizeInput('FM_VinPlot_PlotChoices',label = "Format",choices = c(".pdf",".png",".tiff"),selected = ".png"),
                          tags$head(tags$style(HTML(".shiny-split-layout > div { overflow: visible;}")))
              ),
              br(),
              div(downloadButton(outputId = "FM_VinPlot_download_plot", label = "Download"), align = "center")),
            shinydashboard::box(
              title = tagList(icon("table-cells"),"FeaturePlot"), width =6,  status = "warning", collapsible = TRUE,
              plotOutput('FM_FeaturePlot')%>%withSpinner(),
              splitLayout(cellWidths = c("30%","30%","40%"),
                          numericInput("FM_FeaturePlot_PlotWidth", "Width", min = 0, max = 250, value = 10),
                          numericInput("FM_FeaturePlot_PlotHeight", "Height", min = 0, max = 250, value = 13),
                          selectizeInput('FM_FeaturePlot_PlotChoices',label = "Format",choices = c(".pdf",".png",".tiff"),selected = ".png"),
                          tags$head(tags$style(HTML(".shiny-split-layout > div { overflow: visible;}")))
              ),
              br(),
              div(downloadButton(outputId = "FM_FeaturePlot_download_plot", label = "Download"), align = "center")

          ))
          ),
        tabItem(
          tabName = "four",
          fluidRow(
            column(12,
                   column(11,fluidRow(
                     column(1,valueBoxOutput("vbox_load_tab7",width=NULL)),
                     column(1,valueBoxOutput("vbox_qc_tab7",width=NULL)),
                     column(1,valueBoxOutput("vbox_filter_cell_tab7",width=NULL)),
                     column(1,valueBoxOutput("vbox_NDR_tab7",width=NULL)),
                     column(1,valueBoxOutput("vbox_geneactivity_tab7",width = NULL)),
                     column(1,valueBoxOutput("vbox_findAllmaker_tab7",width=NULL)),
                     column(1,valueBoxOutput("vbox_findIdentsmaker_tab7",width=NULL)),
                     column(1,valueBoxOutput("vbox_annotation_tab7",width = NULL)),
                     column(1,valueBoxOutput("vbox_calling_peak_tab7",width = NULL)),
                     column(1,valueBoxOutput("vbox_GO_plot_tab7",width = NULL)),
                     column(1,valueBoxOutput("vbox_motifs_analysis_tab7",width = NULL)),
                     column(1,valueBoxOutput("vbox_motifs_ident_analysis_tab7",width = NULL))
                     
                   )),
                   column(1,fluidRow(column(1,valueBoxOutput("vbox_footprint_tab7",width = NULL))))
            )),
          fluidRow(
            shinydashboard::box(
              title = tagList(icon("readme"),"Introduction"), width = 12, solidHeader = T, status = "warning", collapsible = TRUE,
              helpText(div(class="my-custom-div",
                           "The Genomic Region Visualization module uses Signac CoveragePlot() to display chromatin accessibility across selected genes, peaks, or genomic coordinates. Accessibility signals from cells in the same cluster or annotated cell type are aggregated into pseudo-bulk tracks for comparison of locus-specific patterns. Gene annotations are overlaid on the tracks, and gene activity distributions can be shown alongside the regional accessibility profiles. Initial peak calling is completed upstream and is not performed in this module."
              )))
          ),
          fluidRow(
            column(4,
                   shinydashboard::box(
                     title = tagList(icon("gears"),"Parameter Setting"), width = NULL,  status = "warning", collapsible = TRUE,
                     radioButtons("AssayRadio3", label = ("Assay:"), choices = list("peaks"),selected = "peaks",inline = T),
                     splitLayout(cellWidths = c("30%","70%"),
                     uiOutput("Chr_num"),
                     uiOutput("Feature3")),
                     uiOutput("gene_name"),
                     # selectInput("IdentSelect1", label = "Group By", choices = list("NULL"="NULL")),

                     splitLayout(cellWidths = c("50%","50%"),
                                 numericInput("range_min", "Distance (-kb):", min = 0, max = 250, value = 50),
                                 numericInput("range_max", "Distance (+kb):", min = 0, max = 250, value = 50)  ),
                     splitLayout(cellWidths = c("50%","50%"),
                                 numericInput("tile_size", "TileSize:", min = 10, max = 5000, value = 250),
                                 numericInput("ymax", "Y-Max (0,1):", min = 0, max = 1, value = 0.99)  ),
                     
                     div(actionButton("submit_GenomicRegionsPlot","Genomic Regions Plot", icon = icon("play-circle")), align = "center"))),
            column(8,
                   shinydashboard::box(
                     title = tagList(icon("chart-column"),"GenomicReginsPlot"), width =NULL,height = 710, status = "warning", collapsible = TRUE,
                     plotOutput("GenomicRegionsPlot",width="100%",height = 550)%>%withSpinner(),
                     splitLayout(cellWidths = c("30%","30%","40%"),
                                 numericInput("GenomicRegionsPlot_PlotWidth", "Width", min = 0, max = 250, value = 10),
                                 numericInput("GenomicRegionsPlot_PlotHeight", "Height", min = 0, max = 250, value = 13),
                                 selectizeInput('GenomicRegionsPlot_PlotChoices',label = "Format",choices = c(".pdf",".png",".tiff"),selected = ".png"),
                                 tags$head(tags$style(HTML(".shiny-split-layout > div { overflow: visible;}")))
                     ),
                     div(downloadButton(outputId = "GenomicRegionsPlot_download_plot", label = "Download"), align = "center"))))),
        tabItem(
          tabName = "sixone",
          fluidRow(
            column(12,
                   column(11,fluidRow(
                     column(1,valueBoxOutput("vbox_load_tab8",width=NULL)),
                     column(1,valueBoxOutput("vbox_qc_tab8",width=NULL)),
                     column(1,valueBoxOutput("vbox_filter_cell_tab8",width=NULL)),
                     column(1,valueBoxOutput("vbox_NDR_tab8",width=NULL)),
                     column(1,valueBoxOutput("vbox_geneactivity_tab8",width = NULL)),
                     column(1,valueBoxOutput("vbox_findAllmaker_tab8",width=NULL)),
                     column(1,valueBoxOutput("vbox_findIdentsmaker_tab8",width=NULL)),
                     column(1,valueBoxOutput("vbox_annotation_tab8",width = NULL)),
                     column(1,valueBoxOutput("vbox_calling_peak_tab8",width = NULL)),
                     column(1,valueBoxOutput("vbox_GO_plot_tab8",width = NULL)),
                     column(1,valueBoxOutput("vbox_motifs_analysis_tab8",width = NULL)),
                     column(1,valueBoxOutput("vbox_motifs_ident_analysis_tab8",width = NULL))
                   )),
                   column(1,fluidRow(column(1,valueBoxOutput("vbox_footprint_tab8",width = NULL))))
                   )
            
          ),
          fluidRow(
            shinydashboard::box(
              title = tagList(icon("readme"),"Introduction"), width = 12,solidHeader = T, status = "warning", collapsible = TRUE,
              helpText(div(class="my-custom-div",
                           "This module uses JASPAR motif annotations to assess transcription factor motif enrichment among differentially accessible peaks from a one-versus-rest comparison. Candidate motifs are presented in a results table, and a sequence logo for a selected motif shows its nucleotide preferences. Motif enrichment supports exploratory interpretation of regulatory factors but does not establish transcription factor binding at an individual site."
                           # style = "font-size:17.5px;font-style:calibri;color:black;",
                           # align = "justify"
              )))
          ),
          # fluidRow(
          #   shinydashboard::box(
          #     title = tagList(icon("gears"),"Parameter Setting"), width =12, status = "warning", collapsible = TRUE,
          #     # div(actionButton("submit111","Run AddMotifs", icon = icon("play-circle")), align = "center"),
          #     # selectInput("IdentSelect1", label = "Ident", choices = list("1","2","3")),
          #     # splitLayout(cellWidths = c("50%","50%"),
          #     #             radioButtons("TestUse3", label = "Method:", choices = list("wilcox"="wilcox","MAST"="MAST","LR"="LR","bimod"="bimod","roc"="roc"), selected = "LR",inline = TRUE),
          #     #             radioButtons("OnlyPos3", label = "Only.pos:", choices = list("True"="True","False"="False"), selected = "False",inline = TRUE),
          #     #                                  ),
          #     DT::dataTableOutput("Markers_Information"),
          #     splitLayout(cellWidths = c("50%","50%"),
          #                 # numericInput(inputId = "LogfcThreshold3", label = "Logfc.threshold:", value = 0.25),
          #                 # numericInput(inputId = "MinPct3", label = "Min.pct:", value = 0.7),
          #                 
          #                 numericInput(inputId = "AllMarkersTopPeaks3", label = "Top n Peaks:", value = 10),
          #                 ))
          #  ),
          
          
            fluidRow(
              shinydashboard::box(
                title = tagList(icon("table-cells"),"Setting"), width=12,status = "warning", collapsible = TRUE,
                
                column(5,
                       
                       splitLayout(cellWidths = c("50%","50%"),
                                   selectizeInput('Ident_motif',label = "Select Cluster:", choices = list("NULL"="NULL"),selected="NULL"),
                                   numericInput(inputId = "Pvalue", label = "pvalueCutoff:", step=0.1,value = 0.05)),
                       # selectizeInput('Ident_motif',label = "Select Ident", choices = list("NULL"="NULL"),selected="NULL"),
                       div(actionButton("submit_MotifFindAllMarkers",HTML("Motifs Analysis"), icon = icon("play-circle")), align = "center")
                       
                       ),
                # column(4,numericInput(inputId = "Pvalue", label = "Pvalue", value = 0.005),
                #        # numericInput(inputId = "MinPct3", label = "MinPct", value = 0.25)
                # ),
                column(7,textAreaInput( "Marker_list1","Marker List:",
                                        value = "",rows =3))
                
              ) 
            ),
          fluidRow(
            column(7,
                   
                   fluidRow(
                     shinydashboard::box(
                       title = tagList(icon("table-cells"),"Motif Table"), width=12,status = "warning", collapsible = TRUE,
                       DT::dataTableOutput("Motif_data1")%>%withSpinner(),
                       br(),
                       div(downloadButton("Motif_download_data1", "Download"), align = "center"))
                     
                   )
            ),
            column(5,
                   shinydashboard::box(
                     title = tagList(icon("chart-column"),"Motif Plot"), width =NULL, status = "warning", collapsible = TRUE,
                     plotOutput("MotifPlot1",width="100%")%>%withSpinner(),
                     splitLayout(cellWidths = c("30%","30%","40%"),
                                 numericInput("MotifPlot1_PlotWidth", "Width", min = 0, max = 250, value = 12),
                                 numericInput("MotifPlot1_PlotHeight", "Height", min = 0, max = 250, value = 8),
                                 selectizeInput('MotifPlot1_PlotChoices',label = "Format",choices = c(".pdf",".png",".tiff"),selected = ".png"),
                                 tags$head(tags$style(HTML(".shiny-split-layout > div { overflow: visible;}")))
                     ),
                     div(downloadButton(outputId = "MotifPlot1_download_plot", label = "Download"), align = "center"))
                   
            ))
        ),
        tabItem(
          tabName = "sixtwo",
          fluidRow(
            column(12,
                   column(11,fluidRow(
                     column(1,valueBoxOutput("vbox_load_tab9",width=NULL)),
                     column(1,valueBoxOutput("vbox_qc_tab9",width=NULL)),
                     column(1,valueBoxOutput("vbox_filter_cell_tab9",width=NULL)),
                     column(1,valueBoxOutput("vbox_NDR_tab9",width=NULL)),
                     column(1,valueBoxOutput("vbox_geneactivity_tab9",width = NULL)),
                     column(1,valueBoxOutput("vbox_findAllmaker_tab9",width=NULL)),
                     column(1,valueBoxOutput("vbox_findIdentsmaker_tab9",width=NULL)),
                     column(1,valueBoxOutput("vbox_annotation_tab9",width = NULL)),
                     column(1,valueBoxOutput("vbox_calling_peak_tab9",width = NULL)),
                     column(1,valueBoxOutput("vbox_GO_plot_tab9",width = NULL)),
                     column(1,valueBoxOutput("vbox_motifs_analysis_tab9",width = NULL)),
                     column(1,valueBoxOutput("vbox_motifs_ident_analysis_tab9",width = NULL))
                     
                   )),
                   column(1,fluidRow(column(1,valueBoxOutput("vbox_footprint_tab9",width = NULL))))
            )
            
          ),
          fluidRow(
            shinydashboard::box(
              title = tagList(icon("readme"),"Introduction"), width = 12,solidHeader = T, status = "warning", collapsible = TRUE,
              helpText(div(class="my-custom-div",
                           "This module examines JASPAR transcription factor motifs in differentially accessible peaks identified between two selected clusters. It presents candidate motifs and allows users to inspect a sequence logo for a selected motif. The motif results are intended to support exploratory regulatory interpretation of the pairwise differential accessibility analysis; enrichment statistics and individual motif matches should be distinguished in the displayed table."
                           # style = "font-size:17.5px;font-style:calibri;color:black;",
                           # align = "justify"
              )))
          ),
          fluidRow(
            shinydashboard::box(
              title = tagList(icon("gears"),"Parameter Setting"), width =12, status = "warning", collapsible = TRUE,
              # selectInput("IdentSelect1", label = "Ident", choices = list("1","2","3")),
              # splitLayout(cellWidths = c("50%","50%"),
              #             radioButtons("TestUse4", label = "Method:", choices = list("wilcox"="wilcox","MAST"="MAST","LR"="LR","bimod"="bimod","roc"="roc"), selected = "LR",inline = TRUE),
              #             radioButtons("OnlyPos4", label = "Only.pos:", choices = list("True"="True","False"="False"), selected = "False",inline = TRUE)),
              # splitLayout(cellWidths = c("50%","50%"),
              #             # numericInput(inputId = "LogfcThreshold4", label = "Logfc.threshold:", value = 0.25),
              #             # numericInput(inputId = "MinPct4", label = "Min.pct:", value = 0.7),
              #             numericInput(inputId = "AllMarkersTopPeaks4", label = "Top n Peaks:", value = 10),
              #             div(actionButton("submit_MotifFindMarkers",HTML("Motifs Idents Table"), icon = icon("play-circle")), align = "center")),
              # # uiOutput("ident_select")
              # splitLayout(cellWidths = c("40%","40%","10"),
              #             numericInput(inputId = "Pvalue1", label = "Pvalue", value = 0.05),
              #             selectInput("Ident41", label = "Select Ident", choices = list("NULL"="NULL"),selected="NULL"),
              #             # selectInput("Ident42", label = "Ident.2:", choices = list("NULL"="NULL"),selected="NULL"),
              #             bsButton('q2',label = '',icon = icon(name = 'question'),size = 'extra-small'),
              #             bsPopover(id = 'q2',title=NULL,
              #                       content ='The values of ident.1 and ident.2 are determines by the selection made within the "Find idents marker" module specifically for those two idents.',
              #                       placement = 'right',trigger = 'hover',options = list(container = 'body')))
             fluidRow(
               column(6,
                      fluidRow(
                        column(6,uiOutput("marker_information")),
                        column(6,
                               splitLayout(cellWidths = c("50%","50%"),
                                           numericInput(inputId = "Pvalue1", label = "pvalueCutoff:", step=0.1,value = 0.05),
                                           numericInput(inputId = "MinPct4", label = "Min.pct:",step=0.1,value = 0.7))   
                        )),
                      fluidRow(
                        column(6,selectInput("Ident41", label = "Select Cluster:", choices = list("NULL"="NULL"),selected="NULL")),
                        column(6,div(actionButton("submit_MotifFindMarkers",HTML("Motifs Idents Analysis"), icon = icon("play-circle")), align = "center") )
                      )
               ),
               column(6,textAreaInput( "Marker_list2","Marker List:",
                                       value = "",rows =3))
             )
              
            )
          ),
          fluidRow(
            column(7,
                   shinydashboard::box(
                     title = tagList(icon("table-cells"),"Motif Table_2"), width =NULL,status = "warning", collapsible = TRUE,
                     DT::dataTableOutput("Motif_data2")%>%withSpinner(),
                     br(),
                     div(downloadButton("Motif_download_data2", "Download"), align = "center"))
                   
                     ),
            column(5,
                   shinydashboard::box(
                     title = tagList(icon("chart-column"),"Motif Plot"), width =NULL, status = "warning", collapsible = TRUE,
                     plotOutput("MotifPlot2",width="100%")%>%withSpinner(),
                     splitLayout(cellWidths = c("30%","30%","40%"),
                                 numericInput("MotifPlot2_PlotWidth", "Width", min = 0, max = 250, value = 12),
                                 numericInput("MotifPlot2_PlotHeight", "Height", min = 0, max = 250, value = 8),
                                 selectizeInput('MotifPlot2_PlotChoices',label = "Format",choices = c(".pdf",".png",".tiff"),selected = ".png"),
                                 tags$head(tags$style(HTML(".shiny-split-layout > div { overflow: visible;}")))
                     ),
                     div(downloadButton(outputId = "MotifPlot2_download_plot", label = "Download"), align = "center"))
            ))
        ),
        tabItem(
          tabName = "five",
          fluidRow(
            column(12,
                   column(11,fluidRow(
                    column(1,valueBoxOutput("vbox_load_tab10",width=NULL)),
                     column(1,valueBoxOutput("vbox_qc_tab10",width=NULL)),
                     column(1,valueBoxOutput("vbox_filter_cell_tab10",width=NULL)),
                     column(1,valueBoxOutput("vbox_NDR_tab10",width=NULL)),
                     column(1,valueBoxOutput("vbox_geneactivity_tab10",width = NULL)),
                     column(1,valueBoxOutput("vbox_findAllmaker_tab10",width=NULL)),
                     column(1,valueBoxOutput("vbox_findIdentsmaker_tab10",width=NULL)),
                     column(1,valueBoxOutput("vbox_annotation_tab10",width = NULL)),
                     column(1,valueBoxOutput("vbox_calling_peak_tab10",width = NULL)),
                     column(1,valueBoxOutput("vbox_GO_plot_tab10",width = NULL)),
                     column(1,valueBoxOutput("vbox_motifs_analysis_tab10",width = NULL)),
                     column(1,valueBoxOutput("vbox_motifs_ident_analysis_tab10",width = NULL))
                   )),
                   column(1,fluidRow(column(1,valueBoxOutput("vbox_footprint_tab10",width = NULL))))
            )
            
           
          ),
          fluidRow(
            shinydashboard::box(
            title = tagList(icon("readme"),"Introduction"), width = 12, solidHeader = T, status = "warning", collapsible = TRUE,
            helpText(div(class="my-custom-div",
                         "The GO Analysis module uses clusterProfiler to assess Gene Ontology enrichment for genes associated with differentially accessible regions or differential gene activity. Users can select one-versus-rest or pairwise results and set significance thresholds. Enriched GO terms are summarized in a table and graphical outputs, including a bar plot. These results support functional interpretation of the selected gene set."
                         # style = "font-size:17.5px;font-style:calibri;color:black;",
                         # align = "justify"
            )))
           ),
          fluidRow(
            column(3,
                   shinydashboard::box(
                     title = tagList(icon("gears"),"Parameter Setting"), width = NULL,  status = "warning", collapsible = TRUE,
                     tabsetPanel(id="GO_setting1",
                     tabPanel("One vs Rest",
                              selectizeInput(inputId = "idents_selected1", label = "Select Cluster:", choices = list("NULL"="NULL"),selected="NULL",
                                    multiple = F,options = NULL),
                              textAreaInput( "Marker_list3","Marker List:",
                                             value = "",rows =5)
                              ),
                     tabPanel("One vs One",
                              selectizeInput(inputId = "idents_selected2", label = "Select Cluster：", choices = list("NULL"="NULL"),selected="NULL",
                                    multiple = F,options = NULL),
                              textAreaInput( "Marker_list4","Marker List:",
                                             value = "",rows =5)
                              )),
                     selectizeInput(inputId = "gene_id_type", label = "Gene ID Type:", choices = c("ENSEMBL", "SYMBOL"),
                                    multiple = F,options = NULL),
                     splitLayout(cellWidths = c("50%","50%"),
                      numericInput("pvalueCutoff", "pvalueCutoff", min = 0, max = 2.5,step=0.1, value = 0.05),
                      numericInput("qvalueCutoff", "qvalueCutoff", min = 0, max = 2.5,step=0.1, value = 0.05)),
                     splitLayout(cellWidths = c("50%","50%"),
                      numericInput("minGSSize", "minGSSize", min = 0, max = 250, value = 10),
                      numericInput("maxGSSize", "maxGSSize", min = 0, max = 250, value = 100)),
                     # numericInput(inputId = "ActivityNcol4", label = "Activity ncol:", value = 2),
                     div(actionButton("submit_GO_analysis","GO analysis", icon = icon("play-circle")), align = "center")
                   )
            ),
            column(9,
                   shinydashboard::box(
                            title = tagList(icon("table-cells"),"GO Enrichment Table"), width =NULL,status = "warning", collapsible = TRUE,
                            tabsetPanel(id="GO_Table",
                                        tabPanel("One vs Rest",
                                                 DT::dataTableOutput("GO_data1")%>%withSpinner(),
                                                 br(),
                                                 div(downloadButton("GO_download_data1", "Download"), align = "center")),                   
                                        tabPanel("One vs One",
                                                 DT::dataTableOutput("GO_data2")%>%withSpinner(),
                                                 br(),
                                                 div(downloadButton("GO_download_data2", "Download"), align = "center")))
                            # DT::dataTableOutput("GO_data")%>%withSpinner(),
                            # br(),
                            # div(downloadButton("GO_download_data", "Download"), align = "center")
                            )
                   )),
          fluidRow(
            shinydashboard::box(
              title = tagList(icon("chart-column"),"GO Plot"), width =12,height = 810, status = "warning", collapsible = TRUE,
              tabsetPanel(id="GO_Plot",
                          tabPanel("One vs Rest",
                                   plotOutput("GO_Plot1",width="80%",height = 590)%>%withSpinner(),
                                   br(),
                                   splitLayout(cellWidths = c("30%","30%","40%"),
                                               numericInput("GO_Plot1_PlotWidth", "Width", min = 0, max = 250, value = 10),
                                               numericInput("GO_Plot1_PlotHeight", "Height", min = 0, max = 250, value = 7),
                                               selectizeInput('GO_Plot1_PlotChoices',label = "Format",choices = c(".pdf",".png",".tiff"),selected = ".png"),
                                               tags$head(tags$style(HTML(".shiny-split-layout > div { overflow: visible;}")))),
                                   div(downloadButton(outputId = "GO_Plot1_download_plot", label = "Download"), align = "center")),                   
                          tabPanel("One vs One",
                                   plotOutput("GO_Plot2",width="80%",height = 590)%>%withSpinner(),
                                   br(),
                                   splitLayout(cellWidths = c("30%","30%","40%"),
                                               numericInput("GO_Plot2_PlotWidth", "Width", min = 0, max = 250, value = 10),
                                               numericInput("GO_Plot2_PlotHeight", "Height", min = 0, max = 250, value = 7),
                                               selectizeInput('GO_Plot2_PlotChoices',label = "Format",choices = c(".pdf",".png",".tiff"),selected = ".png"),
                                               tags$head(tags$style(HTML(".shiny-split-layout > div { overflow: visible;}")))),
                                   div(downloadButton(outputId = "GO_Plot2_download_plot", label = "Download"), align = "center")))
              
            )
          )
          
        ),
        tabItem(
          tabName = "seven",
          fluidRow(
            column(12,column(11,fluidRow(
               column(1,valueBoxOutput("vbox_load_tab11",width=NULL)),
               column(1,valueBoxOutput("vbox_qc_tab11",width=NULL)),
               column(1,valueBoxOutput("vbox_filter_cell_tab11",width=NULL)),
               column(1,valueBoxOutput("vbox_NDR_tab11",width=NULL)),
               column(1,valueBoxOutput("vbox_geneactivity_tab11",width = NULL)),
               column(1,valueBoxOutput("vbox_findAllmaker_tab11",width=NULL)),
               column(1,valueBoxOutput("vbox_findIdentsmaker_tab11",width=NULL)),
               column(1,valueBoxOutput("vbox_annotation_tab11",width = NULL)),
               column(1,valueBoxOutput("vbox_calling_peak_tab11",width = NULL)),
               column(1,valueBoxOutput("vbox_GO_plot_tab11",width = NULL)),
               column(1,valueBoxOutput("vbox_motifs_analysis_tab11",width = NULL)),
               column(1,valueBoxOutput("vbox_motifs_ident_analysis_tab11",width = NULL))
              
             )),
             column(1,fluidRow(column(1,valueBoxOutput("vbox_footprint_tab11",width = NULL))))
            )
            
          ),
          fluidRow(
            shinydashboard::box(
              title = tagList(icon("readme"),"Introduction"), width = 12, solidHeader = T, status = "warning", collapsible = TRUE,
              helpText(div(class="my-custom-div",
                           "The Transcription Factor Footprinting module examines putative transcription factor occupancy patterns using aggregated Tn5 insertion profiles around selected motif instances. Users can select motifs and cell populations of interest and compare normalized footprint profiles across groups. The plots provide evidence complementary to motif enrichment for interpreting candidate regulatory factors. A footprint is an accessibility-based pattern and does not directly measure transcription factor binding."
                           # style = "font-size:17.5px;font-style:calibri;color:black;",
                           # align = "justify"
              )))),
          fluidRow(
            # column(4,
            #        shinydashboard::box(
            #          title = tagList(icon("gears"),"Parameter Setting"), width = NULL,  status = "warning", collapsible = TRUE,
            #          
            #          
            #          # textInput("Motifs5", label = "Motif Name:", value = "SPIB,EHF,CEBPA"),
            #          numericInput(inputId = "ActivityNcol5", label = "Activity Ncol:", value = 2),
            #          
            #        )),
            # column(8,
                   shinydashboard::box(
                     title =tagList(icon("chart-column"),"Transcription Factor Footprinting Plot"), width = 12, status = "warning", collapsible = TRUE,
                     selectizeInput(inputId = "genes_selected1", label = "Motif Name:",choices = list("NULL"="NULL"),selected="NULL",
                                    multiple = T,options = NULL),
                     div(actionButton("submit_FootPrinting","Transcription Factor Footprinting", icon = icon("play-circle")), align = "center"),
                     plotOutput("FootPrintingPlot",width="100%")%>%withSpinner(),
                     splitLayout(cellWidths = c("30%","30%","40%"),
                                 numericInput("FootPrinting_PlotWidth", "Width", min = 0, max = 250, value = 12),
                                 numericInput("FootPrinting_PlotHeight", "Height", min = 0, max = 250, value = 8),
                                 selectizeInput('FootPrinting_PlotChoices',label = "Format",choices = c(".pdf",".png",".tiff"),selected = ".png"),
                                 tags$head(tags$style(HTML(".shiny-split-layout > div { overflow: visible;}")))),
                     div(downloadButton(outputId = "FootPrinting_download_plot", label = "Download"), align = "center")
                   ))),
        tabItem(
          tabName = "eight",
          fluidRow(
            shinydashboard::box(
              title = tagList(icon("readme"),"Help"), width = 12, solidHeader = T, status = "warning", collapsible = TRUE,
              helpText("Import processed scATAC-seq data, then use the modules in the sidebar to review quality control, filter cells, and run downstream analyses. Alignment and initial peak calling must be completed before import. Source code and issues: https://github.com/lixiaoxin661-rgb/SignacShiny.")
              )
            
          )
        ),
        tabItem(
          tabName = "nine",
          fluidRow(
            shinydashboard::box(
              title = tagList(icon("readme"),"About"), width = 12, solidHeader = T, status = "warning", collapsible = TRUE,
              HTML(paste0(
                "<p style='text-align: justify;font-size: 16.5px;color:black;
                                font-style:calibri;
                                word-spacing:2;
                                line-height:1.5;
                                baseline：middle;'>",
                "<b>Contact</b>",
                "<br>If you have any technical or collaboration needs, please contact:",
                "<br>Siwen Xu (siwxu@gdpu.edu.cn)",
                "<br>Yuyan Luo (1620218029@qq.com)",
                "</p>",
                "<br><p style = 'text-align: justify;font-size: 16.5px;color:black;
                                font-style:calibri;
                                word-spacing:2;
                                line-height:1.5;
                                baseline：middle;'>",
                "<b>Code Availability</b>",
                "<br>The source code for SignacShiny can be found in ","<a  href = 'https://github.com/lixiaoxin661-rgb/SignacShiny' target='_blank'>this</a>"," repository.",
                "</p>"
              )))
            
          )
        )
      )
    )
  ),
  footer=dashboardFooter(
    div(
      # class = "footer",
      span("SignacShiny", style = "position:absolute;left:250px;bottom:15px;font-size:24px;font-weight:bold"),
      img(src = "yh.png", style = "position:absolute;bottom:0px;height:60px;right:0px"),
      HTML(paste0(  "</br><p style = ' text-align: center;font-size:1.0em; color: black; line-height: 10%;'>",
                    "<b>Created by</b>: XuLabGDPU | ",
                    "<b>Software</b>: SignacShiny",
                    "</p>",
                    "</br><p style = 'text-align: center; font-size:1.0em; color: black; line-height: 10%;'>",
                    "<b>Address</b>: No. 160, Outer Ring East Road, Panyu District, Guangzhou City, Guangdong Province, China | ",
                    "<b>Postcode</b>: 511400",
                    "</p>",
                    "</br><p style = 'text-align: center; font-size:1.0em; line-height: 10%;'> ",
                    # "<a  href = 'https://github.com/lthevenard/dt_exercises'target='_blank'>Github</a> | ",
                    "<a  href = 'https://www.xulabgdpu.org.cn'target='_blank'>XuLabGDPU</a> | ",
                    "<a  href = 'https://www.xulabgdpu.org.cn/signacShiny'target='_blank'>SignacShiny</a> |",
                    "<a  href = 'https://www.gdpu.edu.cn/'target='_blank'>Guangdong Pharmaceutical University</a> |",
                    "<a href='https://beian.miit.gov.cn/' target='_blank'>黑ICP备2024016624</a>",
                    "</p>"))
    )
  )
)
