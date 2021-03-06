import Vue from "vue"

var Filters = {
    formatDate(date) {
        var d = new Date(date),
            month = '' + (d.getMonth() + 1),
            day = '' + d.getDate(),
            year = d.getFullYear();

        if (month.length < 2)
            month = '0' + month;
        if (day.length < 2)
            day = '0' + day;

        return [year, month, day].join('-');
    },
    getMonthNames() {
        return [
            "january",
            "february",
            "march",
            "april",
            "may",
            "june",
            "july",
            "august",
            "september",
            "october",
            "november",
            "december"
        ]
    },
    formatMonthDate(value, i18n) {
        // value: e.g. "2020-10"
        const tokens = value.split("-");
        const year = tokens[0];
        const monthNum = tokens[1];
        const monthI18nKey = "month." + this.getMonthNames()[monthNum - 1];
        const month = i18n ? i18n.t(monthI18nKey) : monthI18nKey;
        return month + " " + year;
    },
    formatWeekDate(value, i18n) {
        // value: e.g. "2020-50"
        const tokens = value.split("-");
        const year = tokens[0];
        const weekNum = parseInt(tokens[1]);
        return (i18n ? i18n.t("week") : "week") + " " + weekNum + " " + year;
    },
    formatNumber(value) {
        const num = parseFloat(value);

        if (isNaN(num)) {
            return "-";
        }
        return num.toLocaleString();
    },
    formatPercentage(value) {
        const numFormatted = this.formatNumber(value);

        if (!numFormatted || numFormatted == "-") {
            return "-";
        } else {
            return numFormatted + " %";
        }
    },
    formatTime: function (value) {
        if (!value || value.length == 0) {
            return '-'
        }

        var ret = "";
        let hours = parseInt(Math.floor(value / 3600));
        let minutes = parseInt(Math.floor((value - hours * 3600) / 60));
        let seconds = parseInt((value - (hours * 3600 + minutes * 60)) % 60);

        let dHours = hours > 9 ? hours : hours;
        let dMins = minutes > 9 ? minutes : minutes;
        let dSecs = seconds > 9 ? seconds : seconds;

        ret = dSecs + "s";
        if (minutes) {
            ret = dMins + "m " + ret;
        }
        if (hours) {
            ret = dHours + "h " + ret;
        }
        return ret;
    },
};

for (var f in Filters) {
    Vue.filter(f, Filters[f])
}
