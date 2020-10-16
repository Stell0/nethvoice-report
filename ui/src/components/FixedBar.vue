<template>
  <div class="fixedbar">
    <sui-container>
      <strong class="activeFilters">{{$t('menu.active_filters')}}: </strong>

      <!-- label: selected saved search -->
      <div class="ui label" v-if="activeSelectedSearch">
        <span class="field">
          {{$t('filter.saved_search')}}:
        </span>
        <span class="value">
          {{activeSelectedSearch}}
        </span>
      </div>

      <!-- label: group by time value -->
      <div class="ui label" v-if="showFilterTimeGroup && activeFilters.time.group">
        <span class="field">
          {{$t('filter.group_by')}}:
        </span>
        <span class="value">
          {{activeFilters.time.group}}
        </span>
      </div>

      <!-- label: time interval value -->
      <div class="ui label" v-if="showFilterTime && activeFilters.time.range">
        <span class="field">
          {{$t('filter.time_interval')}}:
        </span>
        <span class="value">
          {{$t(`filter.${activeFilters.time.range}`)}}
        </span>
      </div>

    </sui-container>
  </div>
</template>

<script>

export default {
  name: "FixedBar",
  props: [
    "filter",
    "selectedSearch",
    "showFilterTimeGroup",
    "showFilterTime",
    "showFilterGroup",
    "showFilterAgent",
    "showFilterReason",
    "showFilterResult",
    "showFilterIvr",
    "showFilterChoice",
    "showFilterOrigin",
    "showFilterDestination",
    "showFilterTimeSplit",
    "showFilterCaller",
    "showFilterContactName",
    "showFilterNullCall"
  ],
  data() {
    return {
      activeFilters: this.lodash.cloneDeep(this.filter),
      activeSelectedSearch: this.lodash.cloneDeep(this.selectedSearch)

    }
  },
  mounted() {
    this.$root.$on("applyFilters", () => {
      this.activeFilters = this.lodash.cloneDeep(this.filter)
      this.activeSelectedSearch = this.lodash.cloneDeep(this.selectedSearch)

    })
  },
  methods: {

  }
};
</script>

<style lang="scss">
.fixedbar {
  padding: 6px 0px 6px 0px !important;
  margin-top: 25px;
  min-height: 39px !important;
  margin-bottom: 0 !important;
  border-bottom: 1px solid rgba(34, 36, 38, 0.15);
  box-shadow: 0 1px 2px 0 rgba(34, 36, 38, 0.15);

  .label{
    .field {
      font-style: italic;
      font-size: 11px;
      font-weight: 300 !important;
    }

    .value {
      font-weight: 600;
    }
  }

  .ui.container {
    margin-right: 3em !important;
    margin-left: 3em !important;
    width: auto !important;
    text-align: left;

    .activeFilters {
        font-size: 13px;
    }
  }
}
</style>
