# GA4-E-Commerce-Predictive-Analytics-Cloud-Hub
An end-to-end data engineering, cloud analytics, and machine learning pipeline built on Google Cloud Platform (GCP). This project transforms raw, unsegmented Google Analytics 4 (GA4) event streams into structured BigQuery data marts, an enterprise LookML semantic layer, interactive Looker Studio dashboards, and BigQuery ML propensity scoring models for high-intent marketing retargeting.

## 📌 Executive Summary & Business Impact
Modern e-commerce enterprises face severe analytics friction: raw GA4 event streams suffer from unassigned tracking parameters, fragmented user journeys, and high ad-budget waste on low-intent site traffic.  

This project solves those challenges by implementing a production-grade cloud data hub that delivers:
1. Automated Data Quality & Normalization: Cleanses dynamic tracking parameter noise ((data deleted), <Other>) in BigQuery to ensure 100% executive reporting accuracy.
2. Enterprise Governance (LookML): Establishes a single source of truth across product detail views, cart additions, and conversion rates.
3. High-Yield AI Retargeting: Deploys a BigQuery ML purchase propensity classification model that isolates a 12.4% High-Intent Cohort, boosting target propensity conversion scores to 84.51% compared to the 1.61% global baseline.

## 📸 Interactive Dashboard Modules
The project delivers a multi-page interactive analytics hub built in Looker Studio, powered by custom data staging layers in BigQuery:  

Page 1: GA4 Overview & Traffic Acquisition Hub
Tracks macro engagement KPIs and isolates core traffic channels using normalized SQL views.

Page 2: E-Commerce Merchandising & Conversion Funnel
Quantifies top-of-funnel drop-offs and tracks individual SKU conversion friction.

Page 3: AI Predictive Audience & Retargeting Hub
Operationalizes BigQuery ML scoring outputs to group 94.7K scored users into actionable, high-converting ad-retargeting segments.

## 🏗️ End-to-End System Architecture

```text
[ GA4 Raw Event Stream ]
         │
         ▼
[ Google BigQuery Data Warehouse ]
   ├── Staging Layer: `ga4_staging`
   ├── Transformation Views: `vw_clean_traffic_acquisition`
   └── Data Marts: `mart_daily_traffic_acquisition`, `mart_ecommerce_product_funnel`
         │
         ├──► [ LookML Semantic Layer ] ──► Enterprise Metrics Governance
         ├──► [ BigQuery ML Propensity Classifier ] ──► AI Audience Scoring
         └──► [ Looker Studio BI Hub ] ──► Executive Reporting
```

## 🛠️ Technical Capabilities & Competencies
Cloud Infrastructure & Storage: Google Cloud Platform (GCP), BigQuery Data Warehouse

Data Engineering & SQL Transformation: Data Staging, UTM Parsing, Parameter Cleansing, Partitioning & Grouping Views  

Semantic Layer & Data Governance: Looker / LookML (.model.lkml and .view.lkml definitions)Predictive Machine Learning: BigQuery ML (Classification, Propensity Scoring, Audience Clustering)

Business Intelligence & Data Visualization: Looker Studio, Conversion Rate Optimization (CRO) Funnels

##  📂 Repository Layout & Deep-Dive Code Links
```text
├── sql/                                # BigQuery SQL Scripts & Staging Views
│   ├── 01_staging_views.sql            # Clean acquisition channel logic & UTM parsing
│   ├── 02_mart_daily_traffic.sql       # Session-level aggregation data mart
│   ├── 03_mart_product_funnel.sql      # Merchandise conversion funnel mart
│   └── 04_bigquery_ml_propensity.sql   # ML model training, evaluation & scoring
│
├── lookml/                             # Looker Semantic Modeling Layer
│   ├── models/
│   │   └── ga4_ecommerce.model.lkml    # Model definition & explore relationships
│   └── views/
│       ├── mart_daily_traffic.view.lkml
│       ├── mart_product_funnel.view.lkml
│       └── mart_predictive_retargeting.view.lkml
│
├── docs/                               # Project Assets & PDF Export
│   └── GA4_E-Commerce_Analytics_Report.pdf
│
└── README.md                           # Master Project Documentation
```
##  👤 Author & Freelance Consulting

Youssef Jadir

Sales Growth & Cloud Analytics Partner | Flowmingo AI Certified Partner & Google cloud data analyst certified

Specialized in designing end-to-end cloud data pipelines, LookML data modeling, and machine learning analytics on GCP.

💼 LinkedIn: https://www.linkedin.com/in/youssefjadir/

🌐 Upwork Profile: https://www.upwork.com/freelancers/~01a2014428208ede98?mp_source=share

✉️ Contact: jadiryoussef0@gmail.com
