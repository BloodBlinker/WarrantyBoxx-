package com.robinroy.warrantyboxx

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider

/**
 * Home screen widget showing counts of warranties expiring soon
 * (Blueprint Section 2.1 "Home Screen Widget").
 *
 * Reads values written from Flutter via the home_widget plugin and binds them to
 * the widget layout. Tapping the widget deep-links into the app's dashboard.
 */
class WarrantyWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: android.content.SharedPreferences,
    ) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.warranty_widget).apply {
                val count30 = widgetData.getInt("widget_expiring_30", 0)
                val count7 = widgetData.getInt("widget_expiring_7", 0)
                setTextViewText(R.id.widget_expiring_30, "$count30 expiring in 30 days")
                setTextViewText(R.id.widget_expiring_7, "$count7 expiring in 7 days")

                // Tapping opens the app filtered to "expiring soon" (Section 2.1).
                val intent = Intent(Intent.ACTION_VIEW).apply {
                    data = Uri.parse("warrantyvault://item/expiring")
                    setPackage(context.packageName)
                }
                val pendingIntent = PendingIntent.getActivity(
                    context,
                    0,
                    intent,
                    PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE,
                )
                setOnClickPendingIntent(R.id.widget_title, pendingIntent)
                setOnClickPendingIntent(R.id.widget_expiring_30, pendingIntent)
                setOnClickPendingIntent(R.id.widget_expiring_7, pendingIntent)
            }
            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}
